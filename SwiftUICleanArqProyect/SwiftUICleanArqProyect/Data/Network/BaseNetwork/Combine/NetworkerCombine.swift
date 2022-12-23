//
//  NetworkerCombine.swift
//  SwiftUICleanArqProyect
//
//  Created by jose.bustos.local on 23/12/22.
//

import Foundation
import Combine



//llamadas al servidor mediante genericos

protocol NetworkerProtocol: AnyObject {
    func callServer<T>(type: T.Type, request: URLRequest, codeResponse:Int) -> AnyPublisher<T, Error> where T: Decodable
  
}


final class Networker: NetworkerProtocol {
    func callServer<T>(type: T.Type, request: URLRequest, codeResponse:Int) -> AnyPublisher<T, Error> where T : Decodable {
    
        URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap{
                guard let response = $0.response as? HTTPURLResponse,
                       response.statusCode == codeResponse else {

                    throw URLError(.badServerResponse)
                }
                return $0.data
            }
            .decode(type: T.self, decoder: JSONDecoder()) //decode al tipo indicado.
            .receive(on: DispatchQueue.main) //por el hilo principañ
            .eraseToAnyPublisher()
    }
    
   
}
