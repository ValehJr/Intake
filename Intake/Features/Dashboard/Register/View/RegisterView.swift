//
//  RegisterView.swift
//  Intake
//
//  Created by Valeh Ismayilov on 19.01.26.
//

import SwiftUI

struct RegisterView: View {
    @State var name: String = ""
    @State var email: String = ""
    var body: some View {
        ZStack {
            Color.backgroundPrimary
                .ignoresSafeArea(.all)
            VStack(alignment: .leading, spacing: 18) {
                nameField
                emailField
            }
            .padding()
        }
    }
    
    var nameField: some View {
        TextField("", text: $name)
            .customTextField(text: name, placeholder: "Name")
    }
    
    var emailField: some View {
        TextField("", text: $email)
            .customTextField(text: email, placeholder: "Email")
    }
}

#Preview {
    RegisterView()
}
