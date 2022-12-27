//
//  NetworkHeros.swift
//  SwiftUICleanArqProyect
//
//  Created by jose.bustos.local on 27/12/22.
//

import Foundation

protocol NetworkHerosProtocol {
    func getHeros(name:String) async -> [HeroModelResponse]
}


final class NetworkHeros: NetworkHerosProtocol{
    func getHeros(name:String) async -> [HeroModelResponse]{

        var modelReturn = [HeroModelResponse]()
        
        let urlCad : String = "\(ConstantsApp.CONST_API_URL)\(EndPoints.heros.rawValue)"
        var request : URLRequest = URLRequest(url: URL(string: urlCad)!)
        request.httpMethod = HTTPMethods.post
        request.httpBody = try? JSONEncoder().encode(HeroModelRequest(name: name))
        request.addValue(HTTPMethods.content, forHTTPHeaderField: "Content-type")
    
        //Token JWT (habría que extraer de aqui) a algo generico o interceptor
        let JwtToken =  KeyChain().loadKC(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
        if let tokenJWT = JwtToken{
            request.addValue("Bearer \(tokenJWT)", forHTTPHeaderField: "Authorization") //Token
        }
        
        //Call to server
        
        do{
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let resp = response  as? HTTPURLResponse {
                if resp.statusCode == HTTPResponseCodes.SUCCESS {
                    modelReturn = try! JSONDecoder().decode([HeroModelResponse].self, from: data)
                }
            }
            
        }catch{
   
        }
        
        return modelReturn
    }
}



final class NetworkHerosFake: NetworkHerosProtocol{
    func getHeros(name:String) async -> [HeroModelResponse]{

         let model1 = HeroModelResponse(id: UUID(), favorite: true, name: "Goku", description: "Sobran las presentaciones cuando se habla de Goku. El Saiyan fue enviado al planeta Tierra, pero hay dos versiones sobre el origen del personaje. Según una publicación especial, cuando Goku nació midieron su poder y apenas llegaba a dos unidades, siendo el Saiyan más débil. Aun así se pensaba que le bastaría para conquistar el planeta. Sin embargo, la versión más popular es que Freezer era una amenaza para su planeta natal y antes de que fuera destruido, se envió a Goku en una incubadora para salvarle.", photo: "https://cdn.alfabetajuega.com/alfabetajuega/2020/12/goku1.jpg?width=300")
       
        let model2 = HeroModelResponse(id: UUID(), favorite: true, name: "Vegeta", description: "Vegeta es todo lo contrario. Es arrogante, cruel y despreciable. Quiere conseguir las bolas de Dragón y se enfrenta a todos los protagonistas, matando a Yamcha, Ten Shin Han, Piccolo y Chaos. Es despreciable porque no duda en matar a Nappa, quien entonces era su compañero, como castigo por su fracaso. Tras el intenso entrenamiento de Goku, el guerrero se enfrenta a Vegeta y estuvo a punto de morir. Lejos de sobreponerse, Vegeta huye del planeta Tierra sin saber que pronto tendrá que unirse a los que considera sus enemigos.", photo: "https://cdn.alfabetajuega.com/alfabetajuega/2020/12/vegetita.jpg?width=300")
       
        
        return [model1, model2]
    }
}
