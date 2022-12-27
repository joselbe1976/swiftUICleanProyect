//
//  DefaultHerosRepository.swift
//  SwiftUICleanArqProyect
//
//  Created by jose.bustos.local on 27/12/22.
//

import Foundation


//Real
final class DefaultHerosRepository: HerosRepositoryProtocol{
    
    private var Network: NetworkHerosProtocol

    init(network: NetworkHerosProtocol){
        Network = network
    }

    func getHeros(name: String) async -> [HeroModelResponse] {
        return await Network.getHeros(name: name)
    }
}


//Fake
final class DefaultHerosRepositoryFake: HerosRepositoryProtocol{
    private var Network: NetworkHerosProtocol
    init(network: NetworkHerosProtocol = NetworkHerosFake()){
        Network = network
    }
  
    func getHeros(name: String) async -> [HeroModelResponse] {
        return await Network.getHeros(name: name)
    }
}
