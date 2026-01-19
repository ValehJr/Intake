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
    
    func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundStyle(.gray)
                    .padding()
            }
            content
                .foregroundStyle(.textSecondary)
                .padding()
        }
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.textPrimary, lineWidth: 0.5)
        )
    }
}
