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
        var tokenJWT:String = ""

        let urlCad : String = "\(ConstantsApp.CONST_API_URL)\(EndPoints.login.rawValue)"
        let encodeCredencials = "\(user):\(password)".data(using: .utf8)?.base64EncodedString()
        var segCredential : String = ""
        if let credentials = encodeCredencials{
            segCredential = "Basic \(credentials)"
        }
        
        // creamos el request
        var request : URLRequest = URLRequest(url: URL(string: urlCad)!)
        request.httpMethod = HTTPMethods.post
        request.addValue(HTTPMethods.content, forHTTPHeaderField: "Content-type") //Header aplication JSON
        request.addValue(segCredential, forHTTPHeaderField: "Authorization") //Header Basic Authentication
        
        //Call to server
        
        do{
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let resp = response  as? HTTPURLResponse {
                if resp.statusCode == HTTPResponseCodes.SUCCESS {
                    tokenJWT = String(decoding: data, as: UTF8.self) //Asign the Response (Token JWT)
                }
            }
            
        }catch{
            tokenJWT = ""
        }
        return tokenJWT

    }
}


final class NetworkLoginFake: NetworkLoginProtocol{
    func loginApp(user: String, password: String) async -> String {
        return UUID().uuidString
    }
}
