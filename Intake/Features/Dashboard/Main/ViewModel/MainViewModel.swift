//
//  MainViewModel.swift
//  Intake
//
//  Created by Valeh Ismayilov on 19.01.26.
//

import Foundation
import Combine

class MainViewModel: ObservableObject {
    @Published var user: UserEntity = .init(name: "Valeh", email: "i.valehjr@gmail.com")
}
