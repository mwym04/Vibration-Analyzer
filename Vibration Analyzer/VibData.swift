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
    var modifyGram: Double
    var modifyPhase: Double
    
    
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
        self.modifyGram = 0.0
        self.modifyPhase = 0.0
    }
    
}
