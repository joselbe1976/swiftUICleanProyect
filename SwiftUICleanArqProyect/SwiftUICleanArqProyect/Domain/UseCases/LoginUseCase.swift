//
//  LoginInteractor.swift
//  SwiftUICleanArqProyect
//
//  Created by jose.bustos.local on 22/12/22.
//

import Foundation


protocol loginuserCaseProtocol{
    
    var repo: LoginRepositoryProtocol { get set }
    
    func loginApp(user:String, password:String) async -> Bool
    func logout() async -> Void
    func validateToken() async -> Bool
}


final class LoginUseCase: loginuserCaseProtocol{
    var repo: LoginRepositoryProtocol
    
    init(repo: LoginRepositoryProtocol = DefaultLoginRepository(network: NetworkLogin())) {
        self.repo = repo
    }
    
    
    //CLose Session
    func logout() async {
        KeyChain().deleteKC(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
    }
    
    //login in the app. Returns tokenJWT
    func loginApp(user: String, password: String) async -> Bool {
        
        let token = await repo.loginApp(user: user, password: password)
        
        if token != "" {
            KeyChain().saveKC(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN, value: token)
            return true
        } else{
            KeyChain().deleteKC(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
            return false
        }
        
        
    }
    
    func validateToken() async -> Bool{
        //validamos si existe el token: Nota habría que controlar el tiemo de vida del token aqui... en produccion
        if KeyChain().loadKC(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN) != ""{
            return true
        } else {
            return false
        }
    }
    
}


final class LoginUseCaseFake: loginuserCaseProtocol{
    var repo: LoginRepositoryProtocol
    
    init(repo: LoginRepositoryProtocol = DefaultLoginRepositoryFake()) {
        self.repo = repo
    }
    
    
    //CLose Session
    func logout() async {
        KeyChain().deleteKC(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
    }
    
    //login in the app Fake
    func loginApp(user: String, password: String) async -> Bool {
            KeyChain().saveKC(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN, value: "LoginFakeSuccess")
            return true
        
    }
    
    func validateToken() async -> Bool{
        return true
    }
    
}
