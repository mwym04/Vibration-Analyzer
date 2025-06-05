//
//  WeightBalancingView.swift
//  Vibration Analyzer
//
//  Created by LeeMinwoo on 11/14/23.
//

import SwiftUI

struct WeightBalancingView: View {
    
    @Bindable var vibData: VibData
    
    @ObservedObject private var viewModel: WBViewModel = WBViewModel()
    
    @FocusState var focusedField: Field?
    
    @State var isPresented: Bool = false
    @State var isLongPressing: Bool = false
    @State private var modifyPhase: Int?
    @State private var modifyGram: Int?
    
    enum Field {
        case weightGram, weightPhase, computedPhase
    }
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    let generator = UIImpactFeedbackGenerator(style: .light)
    
    var body: some View {
        ScrollViewReader { scrollView in
            Form {
                Section("감도") {
                    HStack {
                        Text("크기:")
                        Spacer()
                        Text(String(format: "%.1f", viewModel.massEffect))
                    }
                    
                    HStack {
                        Text("각도:")
                        Spacer()
                        Text(String(format: "%.1f", viewModel.phaseEffect))
                    }
                }
                
                Section(content: {
                    HStack{
                        Text("무게 :")
                        TextField("무게", value: $modifyGram, formatter: formatter)
                            .onChange(of: modifyGram) { oldValue, newValue in
                                if newValue == nil {
                                    modifyGram = 0
                                }
                                viewModel.calculationApear(vibData: vibData)
                            }
                        Text("g")
                        Spacer()
                        HStack(spacing: 30) {
                            CustomImageView(systemName: "minus.circle", modify: $modifyGram, addValue: -1)
                            CustomImageView(systemName: "plus.circle", modify: $modifyGram, addValue: +1)
                        }
                    }
                    
                    HStack {
                        Text("각도 :")
                        TextField("각도", value: $modifyPhase, formatter: formatter)
    
                            .onChange(of: modifyPhase) { oldValue, newValue in
                                if newValue == nil {
                                    modifyPhase = 0
                                }
                                viewModel.calculationApear(vibData: vibData)
                            }
                        Text("°")
                        Spacer()
                        HStack(spacing: 30) {
                            CustomImageView(systemName: "minus.circle", modify: $modifyPhase, addValue: -1)
                            CustomImageView(systemName: "plus.circle", modify: $modifyPhase, addValue: +1)
                        }
                    }
                    
                    
                    Toggle("기존 웨이트 부착", isOn: $vibData.isAttatched)
                        .onChange(of: vibData.isAttatched) {
                            viewModel.calculationApear(vibData: vibData)
                        }
                }, header: {
                    Text("수정 웨이트 부착")
                }, footer: {
                    Text("기존 웨이트를 떼지않고 수정 웨이트를 붙일 경우 ON")
                        .font(.caption2)
                })
                
                Section("예상 진동") {
                    HStack {
                        Text("진폭:")
                        Spacer()
                        Text(String(format: "%.1f", viewModel.computedMagnitude))
                            .monospacedDigit()
                    }
                    HStack {
                        Text("각도:")
                        Spacer()
                        Text(String(format: "%.1f", viewModel.computedPhase))
                            .monospacedDigit()
                    }
                    .id(Field.computedPhase)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
//            .onAppear(perform: {
//                //vibData.calculation()
//            })
            .onChange(of: focusedField, {
                withAnimation {
                    switch focusedField {
                    case .weightGram:
                        scrollView.scrollTo(Field.computedPhase, anchor: .center)
                    case .weightPhase:
                        scrollView.scrollTo(Field.computedPhase, anchor: .center)
                    case .computedPhase:
                        scrollView.scrollTo(Field.computedPhase, anchor: .center)
                    case nil:
                        scrollView.scrollTo(Field.computedPhase, anchor: .center)
                    }
                }
            })
            Button {
                isPresented = true
            } label: {
                Text("벡터도 보기")
                    .font(.title3)
                    .frame(maxWidth: .infinity, minHeight: 60)
                    .background(Color(red: 100/255, green: 100/255, blue: 100/255))
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                    .foregroundStyle(Color.white)
                    .padding()
            }.sheet(isPresented: $isPresented, content: {
                SheetView(viewModel: viewModel, vibData: vibData)
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
                    .padding()
                    .presentationBackground(Color("Background"))
                    .ignoresSafeArea()
            })

        }
//        .onAppear(perform: {
//            viewModel.calculationApear(vibData: vibData)
//        })
        .onTapGesture {
            focusedField = nil
        }
        .toolbar {
            ToolbarItem(placement: .keyboard) {
                Button("Cancel") {
                    focusedField = nil
                }
            }
            
            ToolbarItem(placement: .keyboard) {
                Button(focusedField == Field.weightPhase ? "Done" : "Next") {
                    switch focusedField {
                    case .weightGram:
                        focusedField = .weightPhase
                    case .weightPhase:
                        focusedField = nil
                    case .computedPhase:
                        focusedField = nil
                    case nil:
                        focusedField = nil
                    }
                }
            }
        }
    }
    
    
}




#Preview {
    WeightBalancingView(vibData: VibData(dataName: "FDF"))
}
