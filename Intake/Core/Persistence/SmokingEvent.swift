//
//  SmokingEvent.swift
//  Intake
//
//  Created by Valeh Ismayilov on 20.01.26.
//

import SwiftData
import SwiftUI

@Model
final class SmokingEvent {
    var timestamp: Date

    init(timestamp: Date = .now) {
        self.timestamp = timestamp
    }
}
