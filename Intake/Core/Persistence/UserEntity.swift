//
//  UserEntity.swift
//  Intake
//
//  Created by Valeh Ismayilov on 19.01.26.
//

import SwiftData
import SwiftUI

@Model
final class UserEntity {
    var name: String
    var email: String

    @Relationship(deleteRule: .cascade)
    var smokingEvents: [SmokingEvent] = []

    var createdAt: Date

    init(name: String, email: String) {
        self.name = name
        self.email = email
        self.createdAt = Date.now
    }
}
