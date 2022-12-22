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
    
    //Token JWT con nuestro propio property wrapper que lee y graba en el KeyChain
    @PersistenceKeyChain(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN) var tokenJWT {
        didSet {
            #if DEBUG
            print("Token Login: \(tokenJWT)")
            #endif
        }
    }
    
    //valida la logica de JWT si está o no OK.
    func validateControlLogin(){
        
        let seconds = 4.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            //solo validamos que haya token, nada mas
            if self.tokenJWT != "" {
                self.statusLogin = .success
            } else{
                self.statusLogin = .error
            }
        }
        
        
    }
    
    
    //cierre de session
    func closeSessionUser(){
        tokenJWT = ""
        statusLogin = .none
    }
}
