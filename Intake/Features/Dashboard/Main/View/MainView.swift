//
//  ContentView.swift
//  Intake
//
//  Created by Valeh Ismayilov on 18.01.26.
//

import SwiftUI


struct MainView<V: UserManaging>: View {
    @StateObject var vm: V
    
    var body: some View {
        ZStack {
            Color.backgroundPrimary
                .ignoresSafeArea(.all)
            VStack(alignment: .leading) {
                titleView
                
                timeView
            }
            .padding()
        }
    }
    
    var titleView: some View {
        Text("Welcome \(vm.user.name)")
            .appFont(weight: .semibold, size: 24,foregroundColor: .textPrimary)
            .frame(maxWidth: .infinity,alignment: .leading)
    }
    
    var timeView: some View {
        HStack() {
            ForEach(0..<6) { i in
                Text("\(i)")
                    .appFont(weight: .medium, size: 18, foregroundColor: .textPrimary)
                    .padding(.horizontal,12)
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 18)
                .stroke(lineWidth: 1)
        }
    }
}

#Preview {
    @Environment(\.modelContext) var modelContext
    MainView(vm: MainViewModel(context: modelContext,user: .init(name: "Valeh", email: "i.valehjr")))
}
