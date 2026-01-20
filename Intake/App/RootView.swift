//
//  RootView.swift
//  Intake
//
//  Created by Valeh Ismayilov on 20.01.26.
//

import SwiftUI
import SwiftData

struct RootView: View {
    @Query private var users: [UserEntity]
    @Environment(\.modelContext) private var context

    var body: some View {
        if let user = users.first {
            MainView(vm: MainViewModel(context: context,user: user))
        } else {
            RegisterView(context: context)
        }
    }
}
