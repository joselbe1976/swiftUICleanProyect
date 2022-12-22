//
//  NetworkLogin.swift
//  SwiftUICleanArqProyect
//
//  Created by jose.bustos.local on 22/12/22.
//

import Foundation

protocol NetworkLoginProtocol {
    func loginApp(user: String, password: String) async -> String
}

final class NetworkLogin: NetworkLoginProtocol{
    func loginApp(user: String, password: String) async -> String {
        //TODO: aqui llamamos a la red
        
        return ""
    }
}


final class NetworkLoginFake: NetworkLoginProtocol{
    func loginApp(user: String, password: String) async -> String {
        return UUID().uuidString
    }
}
