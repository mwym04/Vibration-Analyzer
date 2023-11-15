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
                    TextField("무게", value: $vibData.modifyGram, formatter: formatter)
                        .keyboardType(.decimalPad)
                        .fixedSize(horizontal: true, vertical: true)
                    Text("g")
                    Spacer()
                    Stepper("", value: $vibData.modifyGram, in: 0...10000)
                }
                HStack {
                    Text("각도 :")
                    TextField("각도", value: $vibData.modifyPhase, formatter: formatter)
                        .keyboardType(.decimalPad)
                        .fixedSize(horizontal: true, vertical: true)
                    Text("º")
                    Spacer()
                    Stepper("", value: $vibData.modifyPhase)
                }
                Toggle("기존 웨이트 부착", isOn: $vibData.isAttatched)
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


