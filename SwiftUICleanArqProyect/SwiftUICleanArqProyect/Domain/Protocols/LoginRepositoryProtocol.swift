//
//  LoginRepository.swift
//  SwiftUICleanArqProyect
//
//  Created by jose.bustos.local on 22/12/22.
//

import Foundation

protocol LoginRepositoryProtocol{
    
    func loginApp(user: String, password: String) async -> String
    
}
