//
//  AppState.swift
//  SwiftUICleanArqProyect
//
//  Created by jose.bustos.local on 22/12/22.
//

import SwiftUI


// Control del estado de la App (hace de singleton)
enum LoginStatus{
    case none
    case success
    case error
}


final class AppState: ObservableObject {
    
    //here lo que necesitemos meter... credenciales login, datos globales etr
    @Published var statusLogin : LoginStatus = .none
    
    //Dependences
    private var loginUseCase: loginuserCaseProtocol //interactor for Login Operations
    

    // inicializadores
    init(loginUseCase: loginuserCaseProtocol = LoginUseCase()){
        self.loginUseCase = loginUseCase
    }
    

    
    //valida la logica de JWT si está o no OK.
    func validateControlLogin(){
        Task{
            if (await loginUseCase.validateToken()){
                self.statusLogin = .success
            } else {
                self.statusLogin = .error
            }
        }
    }
    
    
    //cierre de session
    func closeSessionUser(){
        Task{
            await loginUseCase.logout()
            self.statusLogin = .none
        }
    }
}
