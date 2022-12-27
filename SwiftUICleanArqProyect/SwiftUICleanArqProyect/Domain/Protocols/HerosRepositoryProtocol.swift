//
//  HerosRepositoryProtocol.swift
//  SwiftUICleanArqProyect
//
//  Created by jose.bustos.local on 27/12/22.
//

import Foundation


protocol HerosRepositoryProtocol{
    
    func getHeros(name:String) async -> [HeroModelResponse]
    
}
