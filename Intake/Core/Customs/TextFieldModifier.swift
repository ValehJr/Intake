//
//  TextFieldModifier.swift
//  Intake
//
//  Created by Valeh Ismayilov on 19.01.26.
//

import SwiftUI

struct TextFieldViewModifier: ViewModifier {
    let text: String
    let placeholder: String
    let isFocused: Bool

    func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundStyle(.utilityMuted)
                    .padding()
            }

            content
                .foregroundStyle(.textPrimary)
                .padding()
        }
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(
                    isFocused ? Color.accentPrimary.opacity(0.6) : Color.utilityDivider,
                    lineWidth: 1
                )
        )
    }
}
