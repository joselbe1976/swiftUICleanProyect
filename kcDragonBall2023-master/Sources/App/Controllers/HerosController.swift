//
//  File.swift
//  
//
//  Created by JOSE LUIS BUSTOS ESTEBAN
//
import Fluent
import Vapor
import JWT

struct HerosController : RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        
        // Seguridad JWT de un endpoint solo apra pruebas
        let tokenAppjwt = routes.grouped("api","heros")
        tokenAppjwt.post("all", use: allHeros)
        tokenAppjwt.post("create", use: createHero)
        tokenAppjwt.post("location", use: addLocationHero) //añade una localizacion de un hero
        tokenAppjwt.post("locations", use: getLocationsHero) //Lista locations
        tokenAppjwt.delete("location", use: removeLocation)//remove a Location
        tokenAppjwt.post("tranformations", use: getTransformationsHero) //Lista Transformaciones de un hero
        tokenAppjwt.post("tranformation", use: addTransformationHero) //Add Transformation
        tokenAppjwt.delete("tranformation", use: removeTransformation) //Remove Transformation
        
    }
    
    
    
    func createHero(_ req:Request) async throws -> HTTPStatus{
        let _ = try req.jwt.verify(as: PayloadApp.self)
        let requestHero = try req.content.decode(HerosCreateRequest.self)
        
        let Hero = Heros(name: requestHero.name, description: requestHero.description, photo: requestHero.photo)
        
        return try await Hero
            .create(on: req.db)
            .transform(to: .ok)
            .get()
    }
    
    //Transformations of a Hero
    func getTransformationsHero(_ req:Request) async throws -> [HeroTransformations] {
        let _ = try req.jwt.verify(as: PayloadApp.self)
        let requestData  = try req.content.decode(HerosTransformationListRequest.self)
        let idHero = requestData.id
        return try await HeroTransformations
            .query(on: req.db)
            .group(.and){ group in
                group
                    .filter(\.$hero.$id == idHero)
            }
            .all()
            .get() //tranforma a async-throws ->
  
            
    }
    //add tranformation to Hero
    func addTransformationHero(_ req:Request) async throws -> HTTPStatus {
        
        let _ = try req.jwt.verify(as: PayloadApp.self)
        let requestData  = try req.content.decode(HerosTransformationRequest.self)
        let idHero = requestData.id
        let name = requestData.name
        let description = requestData.description
        let photo = requestData.photo
        
        return try await Heros
            .find(idHero, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap{ hero in
                do {
                    
                    let HeroModel = try HeroTransformations(id: UUID(), hero: hero, name: name, description: description, photo: photo)
                    
                    return HeroModel
                        .create(on: req.db)
                        .transform(to: .created)
                    
                } catch {
                    return req.eventLoop.makeFailedFuture(Abort(.badRequest))
                }
            }
            .get()
    }
     
    //Locations of a Hero
    func getLocationsHero(_ req:Request) async throws -> [HerosLocations] {
        let _ = try req.jwt.verify(as: PayloadApp.self)
        let requestData  = try req.content.decode(HerosLocationsListRequest.self)
        let idHero = requestData.id
        return try await HerosLocations
            .query(on: req.db)
            .group(.and){ group in
                group
                    .filter(\.$hero.$id == idHero)
            }
            .all()
            .get() //tranforma a async-throws ->
  
            
    }
     
    
    func addLocationHero(_ req:Request) async throws -> HTTPStatus {
        
        let _ = try req.jwt.verify(as: PayloadApp.self)
        let requestData  = try req.content.decode(HerosLocationsRequest.self)
        let idHero = requestData.id
        let long = requestData.longitud
        let lat = requestData.latitud
        
        return try await Heros
            .find(idHero, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap{ hero in
                do {
                    let HeroModel = try  HerosLocations(id: UUID(), hero: hero, longitud: long, latitud: lat, dateShow: Date())
                    
                    return HeroModel
                        .create(on: req.db)
                        .transform(to: .created)
                    
                } catch {
                    return req.eventLoop.makeFailedFuture(Abort(.badRequest))
                }
            }
            .get()
    }
    
    //remove a location with a ID
    func removeLocation(_ req:Request) async throws -> HTTPStatus {
    
        let _ = try req.jwt.verify(as: PayloadApp.self)
        let requestData  = try req.content.decode(HerosLocationsListRequest.self)
        let idLocation = requestData.id
      
        return try await HerosLocations
            .find(idLocation, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap{ hero in
                return hero.delete(on: req.db).transform(to: .ok)
            }
            .get()

    }
    
    // Remove transofrmation woith ID
    func removeTransformation(_ req:Request) async throws -> HTTPStatus {
        let _ = try req.jwt.verify(as: PayloadApp.self)
        let requestData  = try req.content.decode(HerosTransformationListRequest.self)
        let idTransformation = requestData.id
      
        return try await HeroTransformations
            .find(idTransformation, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap{ trans in
                return trans.delete(on: req.db).transform(to: .ok)
            }
            .get()
    }
    
    
    
    
    func allHeros(_ req:Request) async throws -> [HerosResponse] {
        let payload = try req.jwt.verify(as: PayloadApp.self)
        let idDeveloper : String = payload.identify.uuidString
        
        var filter = try req.content.decode(HerosFilter.self)
        
        //control null filter
        if (filter.name == ""){
            filter.name = "%"
        }
        else{
            filter.name = "%\(filter.name)%"
        }
        
        return try await  Heros
            .query(on: req.db)
            .filter(\.$name, .custom("like"), filter.name)
            .with(\.$developers)
            .all()
            .map{ data in
                
                data.map{ dataDay in
                    
                    //busco si el developer conectado esta como developer del Heroe
                    HerosResponse(id: dataDay.id!, name: dataDay.name, description: dataDay.description, photo: dataDay.photo, favorite: isFavorite(idDeveloper: idDeveloper, data: dataDay))
                }
            }
            .get() //tranforma a async-throws ->
        

    }
    
   
    // Calculamos si tenemos marcado un heroe como favorito
    private func isFavorite(idDeveloper:String, data:Heros) -> Bool{
        var find:Bool = false
        
        data.developers.forEach{ dev in
            if dev.id?.uuidString == idDeveloper {
                find = true
            }
        }
        return find
        
    }
   
}

