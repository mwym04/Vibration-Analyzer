//
//  Item.swift
//  Vibration Analyzer
//
//  Created by LeeMinwoo on 11/13/23.
//

import Foundation
import SwiftData

@Model
final class VibData {
    var id = UUID()
    var dataName: String
    var dataDate: Date
    var vibFirst: String
    var vibSecond: String
    var phsFirst: String
    var phsSecond: String
    var weightGram: String
    var weightPhase: String
    var isAttatched: Bool
    var modifyGram: String
    var modifyPhase: String
    var modifyGramValue: Int
    var modifyPhaseValue: Int
    var massEffect: Double
    var phaseEffect: Double
    var computedMagnitude: Double
    var computedPhase: Double
    
    static let pi = Double.pi
    
    init(dataName: String) {
        self.id = UUID()
        self.dataName = dataName
        self.dataDate = Date()
        self.vibFirst = ""
        self.vibSecond = ""
        self.phsFirst = ""
        self.phsSecond = ""
        self.weightGram = ""
        self.weightPhase = ""
        self.isAttatched = false
        self.modifyGram = ""
        self.modifyPhase = ""
        self.modifyGramValue = 0
        self.modifyPhaseValue = 0
        self.massEffect = 0.0
        self.phaseEffect = 0.0
        self.computedMagnitude = 0.0
        self.computedPhase = 0.0
    }
    
    func calculation() {
        
        let pi: Double = Double.pi
        let x1: Double = (Double(vibFirst) ?? 0) * (cos((Double(phsFirst) ?? 0) / 180 * pi))
        let y1: Double = (Double(vibFirst) ?? 0) * (sin((Double(phsFirst) ?? 0) / 180 * pi))
        let x2: Double = (Double(vibSecond) ?? 0) * (cos((Double(phsSecond) ?? 0) / 180 * pi))
        let y2: Double = (Double(vibSecond) ?? 0) * (sin((Double(phsSecond) ?? 0) / 180 * pi))
        
        massEffect = (sqrt(pow(x2 - x1, 2) + pow((y2 - y1), 2))) / (Double(weightGram) ?? 1) * 100
        
        if (x2 - x1 == 0) {
            phaseEffect = 0
        }
        else {
            phaseEffect = (atan2((y2 - y1), (x2 - x1)) / pi * 180) - (Double(weightPhase) ?? 0)
            while phaseEffect < 0 {
                phaseEffect += 360
            }
        }
        
        let x3: Double = (massEffect * (Double(modifyGram) ?? 0) / 100) * cos((phaseEffect + (Double(modifyPhase) ?? 0)) / 180 * pi)
        let y3: Double = (massEffect * (Double(modifyGram) ?? 0) / 100) * sin((phaseEffect + (Double(modifyPhase) ?? 0)) / 180 * pi)

        computedMagnitude = sqrt(pow((y3 + (isAttatched ? y2 : y1)), 2) + pow(x3 + (isAttatched ? x2 : x1), 2))
        computedPhase = atan2((y3 + (isAttatched ? y2 : y1)), (x3 + (isAttatched ? x2 : x1))) / pi * 180
        
    }
}
