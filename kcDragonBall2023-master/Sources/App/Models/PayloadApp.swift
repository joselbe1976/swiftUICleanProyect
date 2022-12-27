//
//  File.swift
//  
//
//  Created by JOSE LUIS BUSTOS ESTEBAN 
//

import Vapor
import Fluent
import JWT

// JWT Payload
struct PayloadApp : JWTPayload {
    var email : SubjectClaim  // identifica el sujeto principal del JWT
    var expiration : ExpirationClaim // Expiracion time
    
    var identify : UUID // identificador del developer
    
    // funcion de verificacion: me envian
    func verify(using signer: JWTSigner) throws {
        try self.expiration.verifyNotExpired() // verificamos que no haya expirado
    }
}

