//
//  DataSheetView.swift
//  Vibration Analyzer
//
//  Created by LeeMinwoo on 11/14/23.
//

import SwiftUI
import Combine

struct DataInputView: View {
    
    @State var dataName: String = ""
    @State var vibFirst: String = ""
    @State var vibSecond: String = ""
    @State var phsFirst: String = ""
    @State var phsSecond: String = ""
    @State var weightGram: String = ""
    @State var weightPhase: String = ""
    
    var body: some View {
        Form {
            Section("설비명") {
                TextField("설비명", text: $dataName)
                    .keyboardType(.alphabet)
                    .autocorrectionDisabled(true)
            }
            
            Section("0-Shot") {
                HStack {
                    Text("진폭 :")
                    TextField("진폭", text: $vibFirst)
                        .keyboardType(.decimalPad)
                }
                
                HStack {
                    Text("위상 :")
                    TextField("위상", text: $phsFirst)
                        .keyboardType(.decimalPad)
                }
            }
            
            Section("웨이트 부착 위치") {
                HStack {
                    Text("무게 :")
                    TextField("웨이트 무게", text: $weightGram)
                        .keyboardType(.decimalPad)
                }
                
                HStack{
                    Text("각도 :")
                    TextField("웨이트 부착 각도", text: $weightPhase)
                        .keyboardType(.decimalPad)
                }
            }
            
            Section("1-Shot") {
                HStack{
                    Text("진폭 :")
                    TextField("진폭", text: $vibSecond)
                        .keyboardType(.decimalPad)
                }
                
                
                HStack {
                    Text("위상 :")
                    TextField("위상", text: $phsSecond)
                        .keyboardType(.decimalPad)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        
//        ZStack {
//            RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
//                .foregroundStyle(Color.blue)
//                .frame(height: 60)
//                .padding()
//            
//            NavigationLink(destination: WeightBalancingView(vibData: vibData)) {
//                HStack {
//                    Spacer()
//                    Text("계산하기")
//                        .font(.title3)
//                        .padding()
//                        .foregroundStyle(Color.white)
//                        .bold()
//                    Spacer()
//                }
//                .backgroundStyle(Color.blue)
//            }
//        }
//        .toolbar {
//            ToolbarItemGroup(placement: .keyboard) {
//                Button("Cancel") {
//                    focusedField = nil
//                }
//                
//                Spacer()
//                
//                Button(focusedField == .oneShotPhs ? "Done" : "Next") {
//                    switch focusedField {
//                    case .dataName:
//                        focusedField = .zeroShotAmp
//                    case .zeroShotAmp:
//                        focusedField = .zeroShotPhs
//                    case .zeroShotPhs:
//                        focusedField = .weightGram
//                    case .weightGram:
//                        focusedField = .weightPhase
//                    case .weightPhase:
//                        focusedField = .oneShotAmp
//                    case .oneShotAmp:
//                        focusedField = .oneShotPhs
//                    case .oneShotPhs:
//                        focusedField = nil
//                    default:
//                        focusedField = nil
//                    }
//                }
//            }
//        }
    }
}


#Preview {
    DataInputView()
}
