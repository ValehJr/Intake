//
//  ContentView.swift
//  Intake
//
//  Created by Valeh Ismayilov on 18.01.26.
//

import SwiftUI

struct MainView: View {

    @StateObject var vm: MainViewModel
    
    var body: some View {
        ZStack {
            Color.backgroundPrimary
                .ignoresSafeArea(.all)
            VStack(alignment: .leading) {
                titleView
            }
        }
    }
    
    var titleView: some View {
        Text("Welcome \(vm.user.name)")
            .appFont(weight: .semibold, size: 18,foregroundColor: .textPrimary)
            .frame(maxWidth: .infinity,alignment: .leading)
    }
}

#Preview {
    MainView(vm: MainViewModel())
}
