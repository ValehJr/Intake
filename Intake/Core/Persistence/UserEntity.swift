//
//  UserEntity.swift
//  Intake
//
//  Created by Valeh Ismayilov on 19.01.26.
//

import SwiftData
import SwiftUI

@Model
final class UserEntity: Identifiable {
    var id: UUID
    public var name: String
    public var email: String
    
    init(id: UUID = UUID(), name: String, email: String) {
        self.id = id
        self.name = name
        self.email = email
    }
}
