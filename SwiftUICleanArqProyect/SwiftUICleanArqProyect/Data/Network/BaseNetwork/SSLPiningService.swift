//
//  SSLPiningService.swift
//  SwiftUICleanArqProyect
//
//  Created by Jose Luis Bustos Esteban on 5/1/23.
//

import Foundation
import CommonCrypto

public class SSLPining : NSObject{
    
    //Public key of certificate Oscucate with CriptoKit
    private var publicKeyHash :String = ""  //TODO: Remove this for Security: 8vUl2/WyKzqp0sysOZRbFinbIxt5MxFIyRFyVVw6gHo="
   
    
    let rsa2048Asn1Header:[UInt8] = [
    0x30, 0x82, 0x01, 0x22, 0x30, 0x0d, 0x06, 0x09, 0x2a, 0x86, 0x48, 0x86,
    0xf7, 0x0d, 0x01, 0x01, 0x01, 0x05, 0x00, 0x03, 0x82, 0x01, 0x0f, 0x00
    ]
    
    
    
    override init(){
        //SSL Public Key of Domain with CriptoKit generate. Remove this comment
        let dataPK:[UInt8] = [0x3A-0x02,0x5A+0x1C,0x07+0x4E,0x05+0x67,0x1F+0x13,0x1F+0x10,0x11+0x46,0xB4-0x3B,0x3B+0x10,0x4A+0x30,0x9A-0x29,0xB8-0x48,0x20+0x10,0x05+0x6E,0x81-0x08,0x03+0x70,0x29+0x26,0x10+0x4A,0x34+0x1E,0x56+0x0C,0x4B-0x05,0x11+0x58,0x35+0x39,0x33+0x2F,0x8D-0x44,0x09+0x6F,0x2C+0x48,0x57-0x22,0x50-0x03,0x01+0x77,0x7E-0x38,0x69-0x20,0x4F+0x2A,0x0F+0x43,0x37+0x0F,0x3F+0x3A,0x27+0x2F,0x90-0x3A,0xBC-0x45,0x5A-0x24,0xC9-0x62,0x27+0x21,0xB6-0x47,0x03+0x3A]
        
        publicKeyHash = String(data: Data(dataPK), encoding: .utf8)! //convert to String
    }
    
    
    //ejecuta el SSL Pining
    public func DomainPining() async throws -> Bool {
        if  ConstantsApp.isPiningSuccess {
            return true
        }

        //no success, lanzamos
        let urlSes = URLSession(configuration: .ephemeral, delegate: self, delegateQueue: nil)
        let request : URLRequest = URLRequest(url: URL(string: ConstantsApp.urlPining)!)
        let (_, _) = try await urlSes.data(for: request)
        
        return ConstantsApp.isPiningSuccess //returns if is ok the pining or not
    }
}


extension SSLPining : URLSessionDelegate{
    public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        guard let serverTrust = challenge.protectionSpace.serverTrust  else {
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }
        
        if let serverCertificate = SecTrustCopyCertificateChain(serverTrust) as? [SecCertificate] {
            
            //Server Public Key
            let serverPublickey = SecCertificateCopyKey(serverCertificate.first!) //first certificate: Its posible validate multiples.
            let serverPublicKeyData = SecKeyCopyExternalRepresentation(serverPublickey!, nil)!
            let data : Data = serverPublicKeyData as Data
            
            //Server Hash Key in run time
            let serverHashKey = sha256(data: data)

            //Local Hash key Configurate in Xcode
            let localPublicKey = self.publicKeyHash
            
            if serverHashKey == localPublicKey{
                // Success! This is our server
                print("Public key pinning is successfully completed")
                ConstantsApp.isPiningSuccess = true
                completionHandler(.useCredential, URLCredential(trust: serverTrust))
            } else{
                print("Public key pinning ERROR")
                ConstantsApp.isPiningSuccess = false
                completionHandler(.useCredential, URLCredential(trust: serverTrust))
            }
        }
        
        
    }
}


//MARK: - SHA
extension SSLPining{
    private func sha256(data : Data) -> String{
        
        var keyWithHeader = Data(rsa2048Asn1Header)
        keyWithHeader.append(data)
        
        var hash = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        
        keyWithHeader.withUnsafeBytes {
            _ = CC_SHA256($0, CC_LONG(keyWithHeader.count), &hash)
        }
        
        return Data(hash).base64EncodedString()
    }
}
