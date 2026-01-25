//
//  IntakeApp.swift
//  Intake
//
//  Created by Valeh Ismayilov on 18.01.26.
//

import SwiftUI
import SwiftData

@main
struct IntakeApp: App {
    @AppStorage("isDarkMode") private var isDarkMode = false
    let dataController = DataController.shared

    var body: some Scene {
        WindowGroup {
            RootView()
                .modelContainer(dataController.container)
        }
    }
}
