//
//  RootView.swift
//  Intake
//
//  Created by Valeh Ismayilov on 20.01.26.
//

import SwiftUI
import SwiftData

struct RootView: View {
    @State private var user: UserEntity?
    @Environment(\.modelContext) private var context

    var body: some View {
        Group {
            if let user = user {
                MainView(vm: MainViewModel(context: context, user: user))
            } else {
                RegisterView(context: context, onRegistrationComplete: { registeredUser in
                    self.user = registeredUser
                })
            }
        }
        .onAppear {
            loadUser()
        }
    }
    
    private func loadUser() {
        do {
            user = try DataController.shared.getCurrentUser(context: context)
        } catch {
            print("❌ Error loading user: \(error)")
        }
    }
}
