//
//  Item.swift
//  Vibration Analyzer
//
//  Created by LeeMinwoo on 11/13/23.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
