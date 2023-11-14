//
//  WeightBalancingView.swift
//  Vibration Analyzer
//
//  Created by LeeMinwoo on 11/14/23.
//

import SwiftUI

struct WeightBalancingView: View {
    
    @Bindable var vibData: VibData
    
    let pi: Double = Double.pi
    let formatter: NumberFormatter = {
           let formatter = NumberFormatter()
           formatter.numberStyle = .decimal
           return formatter
       }()
    
    var x1: Double { (Double(vibData.vibFirst) ?? 0)  * (cos((Double(vibData.phsFirst) ?? 0) / 180 * pi)) }
    var y1: Double { (Double(vibData.vibFirst) ?? 0) * (sin((Double(vibData.phsFirst) ?? 0) / 180 * pi)) }
    var x2: Double { (Double(vibData.vibSecond) ?? 0) * (cos((Double(vibData.phsSecond) ?? 0) / 180 * pi)) }
    var y2: Double { (Double(vibData.vibSecond) ?? 0) * (sin((Double(vibData.phsSecond) ?? 0) / 180 * pi)) }
    
    var x3: Double {
        if vibData.isAttatched {
            let vib = massEffect * (vibData.modifyGram) / 100
            let phs = phaseEffect + vibData.modifyPhase
            return vib * cos(phs / 180 * pi)
        } else {
            let vib = massEffect * (vibData.modifyGram) / 100
            let phs = phaseEffect + (vibData.modifyPhase)
            return vib * cos(phs / 180 * pi)
        }
    }
    
    var y3: Double {
        let vib = massEffect * (vibData.modifyGram) / 100
        let phs = phaseEffect + (vibData.modifyPhase)
        return vib * sin(phs / 180 * pi)
    }
    
    var massEffect: Double {
        var mass: Double
        if let weightGram = Double(vibData.weightGram) {
            mass = sqrt(pow(x2 - x1, 2) + pow((y2 - y1), 2))
            return mass / weightGram * 100
        }
        return 0
    }
    
    var phaseEffect: Double {
        var phase: Double
        if (x2 - x1) == 0 {
            phase = 0
        } else {
            phase = atan2((y2 - y1), (x2 - x1)) / pi * 180
        }
        while phase < 0 {
            phase += 360
        }
        
        if let weightPhase = Double(vibData.weightPhase) {
            return phase - weightPhase
        }
        return 0
    }
    
    var computedMagnitude: Double {
        let magnitude = sqrt(pow((y3 - (vibData.isAttatched ? y1 : y2)), 2) + pow(x3 - (vibData.isAttatched ? x1 : x2), 2))
        return magnitude
    }
    var computedPhase: Double {
        let phs = atan2((y3 - (vibData.isAttatched ? y1 : y2)), (x3 - (vibData.isAttatched ? x1 : x2))) / pi * 180
        return phs
    }
    
    var body: some View {
        Form {
            Section("감도") {
                HStack {
                    Text("크기:")
                    Spacer()
                    Text(String(format: "%.1f", massEffect))
                }
                
                HStack {
                    Text("각도:")
                    Spacer()
                    Text(String(format: "%.1f", phaseEffect))
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
                    Stepper("", value: $vibData.modifyGram)
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
                    Text(String(format: "%.1f", computedMagnitude))
                }
                HStack {
                    Text("각도:")
                    Spacer()
                    Text(String(format: "%.1f", computedPhase))
                }
            }
        }
    }
}
