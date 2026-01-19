//
//  View+Extension.swift
//  Intake
//
//  Created by Valeh Ismayilov on 18.01.26.
//

import SwiftUI

extension View {
    func appFont(
        weight: Font.Weight,
        size: CGFloat,
        foregroundColor: Color = .primary
    ) -> some View {
        self
            .font(.system(size: size,weight: weight))
            .foregroundColor(foregroundColor)
    }
    
    func customTextField(
        text: String,
        placeholder: String,
    ) -> some View {
        modifier(
            TextFieldViewModifier(
                text: text,
                placeholder: placeholder
            )
        )
    }
}
