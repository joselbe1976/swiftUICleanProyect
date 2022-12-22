//
//  Wrapper+KeyChain.swift
//  SwiftUICleanArqProyect
//
//  Created by jose.bustos.local on 22/12/22.
//

import Foundation

//perisstencia en KeyChain
@propertyWrapper
final class PersistenceKeyChain {
    private var key: String
    
    init(key: String){
        self.key = key
    }
    
    var wrappedValue: String  {
        get {
            if let value =  KeyChain().loadKC(key:key){
                return value
            } else{
                return ""
            }
        }
        set{
            KeyChain().saveKC(key: key, value: newValue)
        }
    }
}
