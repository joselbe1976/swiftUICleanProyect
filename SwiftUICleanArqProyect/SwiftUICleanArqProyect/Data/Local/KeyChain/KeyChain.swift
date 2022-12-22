//
//  KeyCHain.swift
//  SwiftUICleanArqProyect
//
//  Created by jose.bustos.local on 22/12/22.
//
/*
    Nota: Añadimos en SPM esta librería.
    https://github.com/evgenyneu/keychain-swift.git
*/

import Security
import Foundation
import KeychainSwift


final class KeyChain{
    //funcion para Guardar
    @discardableResult func saveKC(key:String, value:String)  -> Bool {
        if let data = value.data(using: .utf8) {
            let keychain = KeychainSwift()
            //keychain.accessGroup = "AH9SPD7BPD.com.babel.xxxxx"
            keychain.set(data, forKey: key)
            return true
        }
        else{
            return false
        }
    }

    //Cargar una Clave
    func loadKC(key:String)  -> String? {
        let keychain = KeychainSwift()
        //keychain.accessGroup = "AH9SPD7BPD.com.babel.xxxxx"
        if let data = keychain.get(key){
                return data
        }
        else{
                return ""
        }
    }

    //eliminar una clave
    func deleteKC(key:String)  {
        let keychain = KeychainSwift()
        //keychain.accessGroup = "AH9SPD7BPD.com.babel.xxxxx"

        keychain.delete(key)
    }

}
