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
    case notValidate
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
    

    //Login
    @MainActor
    func loginApp(user:String, pass:String){
        Task{
            if (await loginUseCase.loginApp(user: user, password: pass)){
                    self.statusLogin = .success
                
            } else {
                self.statusLogin = .error
            }
        }
    }
    
    
    
    //valida la logica de JWT si está o no OK.
    @MainActor
    func validateControlLogin(){
        Task{
            if (await loginUseCase.validateToken()){
                    self.statusLogin = .success
                
            } else {
                self.statusLogin = .notValidate
            }
        }
    }
    
    
    //cierre de session
    @MainActor
    func closeSessionUser(){
        Task{
            await loginUseCase.logout()
            self.statusLogin = .none
        }
    }
}
