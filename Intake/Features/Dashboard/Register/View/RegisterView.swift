//
//  RegisterView.swift
//  Intake
//
//  Created by Valeh Ismayilov on 19.01.26.
//

import SwiftUI
import SwiftData

struct RegisterView: View {
    @FocusState private var isFocusedName: Bool
    @FocusState private var isFocusedEmail: Bool

    @StateObject private var vm: RegisterViewModel

    init(context: ModelContext) {
        _vm = StateObject(wrappedValue: RegisterViewModel(context: context))
    }
    
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
        TextField("", text: $vm.name)
            .textContentType(.name)
            .autocorrectionDisabled()
            .focused($isFocusedName)
            .customTextField(text: vm.name, placeholder: "Name",isFocused: isFocusedName)
    }

    var emailField: some View {
        TextField("", text: $vm.email)
            .textContentType(.emailAddress)
            .keyboardType(.emailAddress)
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .focused($isFocusedEmail)
            .customTextField(text: vm.email, placeholder: "Email",isFocused: isFocusedEmail)
    }

    var submitButton: some View {
        Button {
            vm.userRegister()
        } label: {
            Text("Submit")
                .appFont(weight: .medium, size: 18,foregroundColor: .backgroundPrimary)
                .frame(maxWidth: .infinity)
                .padding()
                .background(vm.isSubmitButtonActive ? Color.accentPrimary : Color.accentPrimary.opacity(0.6))
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .disabled(!vm.isSubmitButtonActive)
        
    }
}

#Preview {
    @Environment(\.modelContext) var modelContext
    RegisterView(context: modelContext)
}
