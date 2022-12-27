//
//  HerosModel.swift
//  SwiftUICleanArqProyect
//
//  Created by jose.bustos.local on 27/12/22.
//

import Foundation

struct HeroModelResponse: Codable, Identifiable{
    let id: UUID
    let favorite: Bool
    let name:String
    let description:String
    let photo:String
}

//Filter the request od Heros by name
struct HeroModelRequest: Codable {
    let name: String
}
