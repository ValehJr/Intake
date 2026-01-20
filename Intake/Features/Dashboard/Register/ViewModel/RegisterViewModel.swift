//
//  RegisterViewModel.swift
//  Intake
//
//  Created by Valeh Ismayilov on 19.01.26.
//

import Foundation
import Combine
import SwiftData

@MainActor
class RegisterViewModel: ObservableObject {
    private let context: ModelContext
    
    @Published var user: UserEntity? = nil
    @Published var name: String = ""
    @Published var email: String = ""
    
    var isSubmitButtonActive: Bool {
        !name.isEmpty && !email.isEmpty && email.isValidEmail
    }
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func userRegister() {
        guard isSubmitButtonActive else { return }
        
        let user = UserEntity(name: name, email: email)
        context.insert(user)
        
        do {
            try context.save()
        } catch {
            fatalError("Failed to save user: \(error)")
        }
    }
}
