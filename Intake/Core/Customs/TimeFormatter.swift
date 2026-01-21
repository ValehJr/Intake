//
//  TimeFormatter.swift
//  Intake
//
//  Created by Valeh Ismayilov on 21.01.26.
//

import SwiftUI

struct TimeFormatter {
    static let hourly: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "ha"
        return formatter
    }()
}
