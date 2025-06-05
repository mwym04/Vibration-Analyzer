//
//  WBViewModel.swift
//  Vibration Analyzer
//
//  Created by LeeMinwoo on 7/31/24.
//

import Foundation

class WBViewModel: ObservableObject {
    @Published var massEffect: Double = 0.0
    @Published var phaseEffect: Double = 0.0
    @Published var computedMagnitude: Double = 0.0
    @Published var computedPhase: Double = 0.0
    @Published var x1: Double = 0
    @Published var x2: Double = 0
    @Published var x3: Double = 0
    @Published var y1: Double = 0
    @Published var y2: Double = 0
    @Published var y3: Double = 0
    
    func calculationApear(vibData: VibData) {
        let pi = Double.pi
        
        let x1 = (Double(vibData.vibFirst) ?? 0) * (cos((Double(vibData.phsFirst) ?? 0) / 180 * pi))
        let y1 = (Double(vibData.vibFirst) ?? 0) * (sin((Double(vibData.phsFirst) ?? 0) / 180 * pi))
        let x2 = (Double(vibData.vibSecond) ?? 0) * (cos((Double(vibData.phsSecond) ?? 0) / 180 * pi))
        let y2 = (Double(vibData.vibSecond) ?? 0) * (sin((Double(vibData.phsSecond) ?? 0) / 180 * pi))
        
        let massEffect = (sqrt(pow(x2 - x1, 2) + pow((y2 - y1), 2))) / (Double(vibData.weightGram) ?? 1) * 100
        
        var phaseEffect: Double
        
        if (x2 - x1 == 0) {
            phaseEffect = 0
        } else {
            phaseEffect = (atan2((y2 - y1), (x2 - x1)) / pi * 180) - (Double(vibData.weightPhase) ?? 0)
            while phaseEffect < 0 {
                phaseEffect += 360
            }
        }
        
        let x3: Double = (massEffect * (Double(vibData.modifyGram ?? 0)) / 100) * cos((phaseEffect + (Double(vibData.modifyPhase ?? 0))) / 180 * pi)
        let y3 = (massEffect * (Double(vibData.modifyGram ?? 0)) / 100) * sin((phaseEffect + (Double(vibData.modifyPhase ?? 0))) / 180 * pi)
        
        let computedMagnitude = sqrt(pow((y3 + (vibData.isAttatched ? y2 : y1)), 2) + pow(x3 + (vibData.isAttatched ? x2 : x1), 2))
        var computedPhase = atan2((y3 + (vibData.isAttatched ? y2 : y1)), (x3 + (vibData.isAttatched ? x2 : x1))) / pi * 180
        
        while computedPhase < 0 {
            computedPhase += 360
        }
        
        self.massEffect = massEffect
        self.phaseEffect = phaseEffect
        self.computedMagnitude = computedMagnitude
        self.computedPhase = computedPhase
        self.x1 = x1
        self.x2 = x2
        self.x3 = x3
        self.y1 = y1
        self.y2 = y2
        self.y3 = y3
        
    }
    
    /* func calculation(vibData: VibData) {
        let pi = Double.pi
        let x1 = self.x1
        let y1 = self.x2
        let x2 = self.y1
        let y2 = self.y2
        let massEffect = self.massEffect
        let phaseEffect = self.phaseEffect
        
        let x3: Double = (massEffect * (Double(self.modifyGram ?? 0)) / 100) * cos((phaseEffect + (Double(self.modifyPhase ?? 0))) / 180 * pi)
        let y3 = (massEffect * (Double(vibData.modifyGram ?? 0)) / 100) * sin((phaseEffect + (Double(self.modifyPhase ?? 0))) / 180 * pi)
        
        let computedMagnitude = sqrt(pow((y3 + (vibData.isAttatched ? y2 : y1)), 2) + pow(x3 + (vibData.isAttatched ? x2 : x1), 2))
        var computedPhase = atan2((y3 + (vibData.isAttatched ? y2 : y1)), (x3 + (vibData.isAttatched ? x2 : x1))) / pi * 180
        
        while computedPhase < 0 {
            computedPhase += 360
        }
        
        self.computedMagnitude = computedMagnitude
        self.computedPhase = computedPhase
        self.x3 = x3
        self.y3 = y3
    }
     */
}
