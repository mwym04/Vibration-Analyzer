//
//  DataSheetView.swift
//  Vibration Analyzer
//
//  Created by LeeMinwoo on 11/14/23.
//

import SwiftUI

struct DataInputView: View {
    
    @Bindable var vibData: VibData
    @FocusState var focusedField: Field?
    
    let formatter: NumberFormatter = {
           let formatter = NumberFormatter()
           formatter.numberStyle = .decimal
           return formatter
       }()
    
    enum Field {
        case dataName
        case zeroShotAmp
        case zeroShotPhs
        case weightGram
        case weightPhase
        case oneShotAmp
        case oneShotPhs
    }
    
    
    var body: some View {
            ScrollViewReader { scrollView in
                Form {
                    Section("제목") {
                        TextField("제목", text: $vibData.dataName)
                            .focused($focusedField, equals: .dataName)
                            .id(Field.dataName)
                            .keyboardType(.alphabet)
                            .autocorrectionDisabled(true)
                            .submitLabel(.next)
                            .onSubmit {
                                focusedField = .zeroShotAmp
                            }
                    }
                    
                    Section("0-Shot") {
                        TextField("진폭", text: $vibData.vibFirst)
                            .keyboardType(.decimalPad)
                            .focused($focusedField, equals: .zeroShotAmp)
                            .id(Field.zeroShotAmp)
                        TextField("위상", text: $vibData.phsFirst)
                            .keyboardType(.decimalPad)
                            .focused($focusedField, equals: .zeroShotPhs)
                            .id(Field.zeroShotPhs)

                    }
                    
                    Section("웨이트 부착 위치") {
                        HStack {
                            TextField("웨이트 무게", text: $vibData.weightGram)
                                .keyboardType(.decimalPad)
                                .focused($focusedField, equals: .weightGram)
                                .id(Field.weightGram)

                        }
                        TextField("웨이트 부착 위치", text: $vibData.weightPhase)
                            .keyboardType(.decimalPad)
                            .focused($focusedField, equals: .weightPhase)
                            .id(Field.weightPhase)

                    }
                    
                    Section("1-Shot") {
                        TextField("진폭", text: $vibData.vibSecond)
                            .keyboardType(.decimalPad)
                            .focused($focusedField, equals: .oneShotAmp)
                            .id(Field.oneShotAmp)

                        
                        TextField("위상", text: $vibData.phsSecond)
                            .keyboardType(.decimalPad)
                            .focused($focusedField, equals: .oneShotPhs)
                            .id(Field.oneShotPhs)
                    }
                }
                .onChange(of: focusedField, {
                    withAnimation {
                        switch focusedField {
                        case .dataName:
                            scrollView.scrollTo(Field.dataName)
                        case .zeroShotAmp:
                            scrollView.scrollTo(Field.zeroShotPhs)
                        case .zeroShotPhs:
                            scrollView.scrollTo(Field.weightGram)
                        case .weightGram:
                            scrollView.scrollTo(Field.weightPhase)
                        case .weightPhase:
                            scrollView.scrollTo(Field.oneShotAmp)
                        case .oneShotAmp:
                            scrollView.scrollTo(Field.oneShotPhs)
                        case .oneShotPhs:
                            scrollView.scrollTo(Field.oneShotPhs)
                        case nil:
                            scrollView.scrollTo(Field.oneShotPhs)
                        }
                    }
                })
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Button("Cancel") {
                        focusedField = nil
                    }
                    
                    Spacer()
                    
                    Button(focusedField == .oneShotPhs ? "Done" : "Next") {
                        switch focusedField {
                        case .dataName:
                            focusedField = .zeroShotAmp
                        case .zeroShotAmp:
                            focusedField = .zeroShotPhs
                        case .zeroShotPhs:
                            focusedField = .weightGram
                        case .weightGram:
                            focusedField = .weightPhase
                        case .weightPhase:
                            focusedField = .oneShotAmp
                        case .oneShotAmp:
                            focusedField = .oneShotPhs
                        case .oneShotPhs:
                            focusedField = nil
                        default:
                            focusedField = nil
                        }
                    }
                }
            }
        
            NavigationLink(destination: WeightBalancingView(vibData: vibData)) {
                HStack {
                    Spacer()
                    Text("계산하기")
                        .font(.title3)
                        .padding()
                        .foregroundStyle(Color.white)
                        .bold()
                    Spacer()
                }
                .background(Color.blue)
            }
        }
}

#Preview {
    DataInputView(vibData: VibData(dataName: "FDF"))
}
