//
//  MainViewModel.swift
//  Intake
//
//  Created by Valeh Ismayilov on 19.01.26.
//

import Foundation
import Combine
import SwiftData

protocol UserManaging: ObservableObject {
    var user: UserEntity { get }
    func addSmokingEvent()
}

@MainActor
final class MainViewModel: ObservableObject, UserManaging {
    @Published var user: UserEntity
    let context: ModelContext

    init(context: ModelContext, user: UserEntity) {
        self.context = context
        self.user = user
    }
    
    func addSmokingEvent() {
        let event = SmokingEvent()
        user.smokingEvents.append(event)
    }
}
