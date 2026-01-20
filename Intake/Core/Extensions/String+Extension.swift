//
//  String+Extension.swift
//  Intake
//
//  Created by Valeh Ismayilov on 20.01.26.
//

import SwiftUI

extension String {
    var isValidEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
}
