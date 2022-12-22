//
//  ViewRouter.swift
//  SwiftUICleanArqProyect
//
//  Created by jose.bustos.local on 22/12/22.
//

import SwiftUI

// Views que gestiona el router principal de la App
enum Screen {
    case login
    case splash
    case home
}

// Clase router inicial de la App
final class ViewRouter: ObservableObject {
    @Published var screen: Screen = .splash
}
