//
//  WeightBalancingView.swift
//  Vibration Analyzer
//
//  Created by LeeMinwoo on 11/14/23.
//

import SwiftUI

struct WeightBalancingView: View {
    
    @Bindable var vibData: VibData
    
    let formatter: NumberFormatter = {
           let formatter = NumberFormatter()
           formatter.numberStyle = .decimal
           return formatter
       }()
    
    var body: some View {
        Form {
            Section("감도") {
                HStack {
                    Text("크기:")
                    Spacer()
                    Text(String(format: "%.1f", vibData.massEffect))
                }
                
                HStack {
                    Text("각도:")
                    Spacer()
                    Text(String(format: "%.1f", vibData.phaseEffect))
                }
            }

            Section(content: {
                HStack {
                    Text("무게 :")
                    TextField("무게", text: $vibData.modifyGram)
                        .onChange(of: vibData.modifyGram, { oldValue, newValue in
                            vibData.modifyGramValue = Int(newValue) ?? 0
                            vibData.calculation()
                        })
                        .keyboardType(.numberPad)
                        .fixedSize(horizontal: true, vertical: true)
                    Text("g")
                    Spacer()
                    Stepper("", value: $vibData.modifyGramValue, in: 0...10000)
                        .onChange(of: vibData.modifyGramValue) { oldValue, newValue in
                            vibData.modifyGram = String(newValue)
                        }
                }
                HStack {
                    Text("각도 :")
                    TextField("각도", text: $vibData.modifyPhase)
                        .onChange(of: vibData.modifyPhase, { oldValue, newValue in
                            vibData.modifyPhaseValue = Int(newValue) ?? 0
                            vibData.calculation()
                        })
                        
                        .keyboardType(.numberPad)
                        .fixedSize(horizontal: true, vertical: true)
                    
                    Text("º")
                    Spacer()
                    Stepper("", value: $vibData.modifyPhaseValue, in: 0...10000)
                        .onChange(of: vibData.modifyPhaseValue) { oldValue, newValue in
                            vibData.modifyPhase = String(newValue)
                        }
                }
                Toggle("기존 웨이트 부착", isOn: $vibData.isAttatched)
                    .onChange(of: vibData.isAttatched) {
                        vibData.calculation()
                    }
            }, header: {
                Text("수정 웨이트 부착")
            }, footer: {
                Text("기존 웨이트를 떼지않고 수정 웨이트를 붙일 경우 ON")
            })
            
            Section("예상 진동") {
                HStack {
                    Text("진폭:")
                    Spacer()
                    Text(String(format: "%.1f", vibData.computedMagnitude))
                }
                HStack {
                    Text("각도:")
                    Spacer()
                    Text(String(format: "%.1f", vibData.computedPhase))
                }
            }
        }
        .onAppear(perform: {
            vibData.calculation()
        })
    }
}


