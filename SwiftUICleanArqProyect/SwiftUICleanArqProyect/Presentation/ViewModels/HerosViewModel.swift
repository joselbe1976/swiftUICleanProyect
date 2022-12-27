//
//  HerosViewModel.swift
//  SwiftUICleanArqProyect
//
//  Created by jose.bustos.local on 27/12/22.
//

import Foundation
import Combine

final class HerosViewModel: ObservableObject {
    @Published var herosData =  [HeroModelResponse]()
    
    private var useCaseHeros : herosUserCaseProtocol
    
    init(useCase: herosUserCaseProtocol = HerosUseCase()){
        useCaseHeros = useCase
    }
    
    func getHeros() async{
        let data = await useCaseHeros.getHeros(name: "") // not apply now the filter...
        
        DispatchQueue.main.async{
            self.herosData = data
        }
        
    }
    
}
