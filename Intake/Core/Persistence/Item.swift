//
//  Item.swift
//  Intake
//
//  Created by Valeh Ismayilov on 18.01.26.
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
