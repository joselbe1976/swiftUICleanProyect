//
//  DefaultLoginRepository.swift
//  SwiftUICleanArqProyect
//
//  Created by jose.bustos.local on 22/12/22.
//

import Foundation

//Real
final class DefaultLoginRepository: LoginRepositoryProtocol{
    
    private var Network: NetworkLoginProtocol
    init(network: NetworkLoginProtocol){
        Network = network
    }
  
    func loginApp(user: String, password: String) async -> String {
        return await Network.loginApp(user: user, password: password)
    }
}


//Fake
final class DefaultLoginRepositoryFake: LoginRepositoryProtocol{
    private var Network: NetworkLoginProtocol
    init(network: NetworkLoginProtocol = NetworkLoginFake()){
        Network = network
    }
  
    func loginApp(user: String, password: String) async -> String {
        return await Network.loginApp(user: user, password: password)
    }
}
