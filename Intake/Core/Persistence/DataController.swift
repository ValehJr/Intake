//
//  DataController.swift
//  Intake
//
//  Created by Valeh Ismayilov on 24.01.26.
//


import SwiftData
import Foundation

class DataController {
    static let shared = DataController()
    let container: ModelContainer
    
    init() {
        let appGroupID = "group.com.valehjr.Intake"
        let schema = Schema([UserEntity.self, SmokingEvent.self])
        
        if let groupURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroupID) {
            let fullURL = groupURL.appendingPathComponent("default.store")
            let config = ModelConfiguration(schema: schema, url: fullURL)
            
            do {
                container = try ModelContainer(for: schema, configurations: [config])
            } catch {
                print("❌ App Group Storage failed: \(error.localizedDescription)")
                container = try! ModelContainer(for: schema, configurations: [ModelConfiguration(isStoredInMemoryOnly: true)])
            }
        } else {
            print("⚠️ WARNING: App Group not found. Falling back to Local Storage.")
            container = try! ModelContainer(for: schema, configurations: [ModelConfiguration(isStoredInMemoryOnly: false)])
        }
    } 
}


extension DataController {
    @MainActor
    func getCurrentUser(context: ModelContext) throws -> UserEntity? {
        let descriptor = FetchDescriptor<UserEntity>()
        let users = try context.fetch(descriptor)
        
        if let existingUser = users.first {
            return existingUser
        } else {
            print("ℹ️ No user found")
            return nil
        }
    }
    
    @MainActor
    func getOrCreateUser(context: ModelContext) throws -> UserEntity {
        if let user = try getCurrentUser(context: context) {
            return user
        } else {
            let newUser = UserEntity(name: "User", email: "")
            context.insert(newUser)
            try context.save()
            return newUser
        }
    }
    
    @MainActor
    func userExists(context: ModelContext) -> Bool {
        let descriptor = FetchDescriptor<UserEntity>()
        let count = (try? context.fetchCount(descriptor)) ?? 0
        return count > 0
    }
}
