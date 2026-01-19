//
//  RegisterView.swift
//  Intake
//
//  Created by Valeh Ismayilov on 19.01.26.
//

import SwiftUI

struct RegisterView: View {
    @State var name = ""
    @State var email = ""
    @FocusState private var isFocusedName: Bool
    @FocusState private var isFocusedEmail: Bool
    
    var body: some View {
        ZStack {
            Color.backgroundPrimary
                .ignoresSafeArea()

            VStack(spacing: 24) {
                header

                VStack(spacing: 16) {
                    nameField
                    emailField
                }
                
                Spacer()
                submitButton

            }
            .padding(.horizontal, 24)
            .padding(.vertical, 32)
        }
    }

    var header: some View {
        VStack(spacing: 8) {
            Text("Welcome to Intake")
                .appFont(weight: .semibold, size: 28,foregroundColor: .textPrimary)

            Text("Create your account to continue")
                .appFont(weight: .medium, size: 18,foregroundColor: .textSecondary)
        }
    }

    var nameField: some View {
        TextField("", text: $name)
            .textContentType(.name)
            .autocorrectionDisabled()
            .focused($isFocusedName)
            .customTextField(text: name, placeholder: "Name",isFocused: isFocusedName)
    }

    var emailField: some View {
        TextField("", text: $email)
            .textContentType(.emailAddress)
            .keyboardType(.emailAddress)
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .focused($isFocusedEmail)
            .customTextField(text: email, placeholder: "Email",isFocused: isFocusedEmail)
    }

    var submitButton: some View {
        Button(action: {}) {
            Text("Submit")
                .appFont(weight: .medium, size: 18,foregroundColor: .backgroundPrimary)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.accentPrimary)
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}

#Preview {
    RegisterView()
}
