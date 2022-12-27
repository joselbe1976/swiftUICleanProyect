//
//  HerosUserCase.swift
//  SwiftUICleanArqProyect
//
//  Created by jose.bustos.local on 27/12/22.
//

import Foundation



protocol herosUserCaseProtocol{
    
    var repo: HerosRepositoryProtocol { get set }
    
    func getHeros(name:String) async -> [HeroModelResponse]

}



// Real
final class HerosUseCase: herosUserCaseProtocol{
   
    var repo: HerosRepositoryProtocol
    
    init(repo: HerosRepositoryProtocol = DefaultHerosRepository(network: NetworkHeros())) {
        self.repo = repo
    }
    
    func getHeros(name: String) async -> [HeroModelResponse] {
        return await repo.getHeros(name: name)
    }
    
}


// Fake
final class HerosUseCaseFake: herosUserCaseProtocol{
   
    var repo: HerosRepositoryProtocol
    
    init(repo: HerosRepositoryProtocol = DefaultHerosRepositoryFake()) {
        self.repo = repo
    }
    
    func getHeros(name: String) async -> [HeroModelResponse] {
        return await repo.getHeros(name: name)
    }
    
}
