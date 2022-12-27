//
//  DomainTest.swift
//  SwiftUICleanArqProyectTests
//
//  Created by jose.bustos.local on 23/12/22.
//

import XCTest
@testable import SwiftUICleanArqProyect

final class DomainTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoginFake() async throws  {
        
        let CK = KeyChain()
        XCTAssertNotNil(CK)
            
        let obj = LoginUseCaseFake()
        XCTAssertNotNil(obj)
        
        //Validate Token
        let resp = await obj.validateToken()
        XCTAssertEqual(resp, true)
        
        
        // login
        let loginDo = await obj.loginApp(user: "", password: "")
        XCTAssertEqual(loginDo, true)
        var jwt = CK.loadKC(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
        XCTAssertNotEqual(jwt, "")
        
        //Close Session
        await obj.logout()
        jwt = CK.loadKC(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
        XCTAssertEqual(jwt, "")
    }

    
    func testLoginReal() async throws  {
        let CK = KeyChain()
        XCTAssertNotNil(CK)
        //reset the token
        CK.saveKC(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN, value: "")
        
        //Caso se uso con repo Fake
        let userCase = LoginUseCase(repo: DefaultLoginRepositoryFake())
        XCTAssertNotNil(userCase)
        
        //validacion
        let resp = await userCase.validateToken()
        XCTAssertEqual(resp, false)
        
        //login
        let loginDo = await userCase.loginApp(user: "", password: "")
        XCTAssertEqual(loginDo, true)
        var jwt = CK.loadKC(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
        XCTAssertNotEqual(jwt, "")
        
        //Close Session
        await userCase.logout()
        jwt = CK.loadKC(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
        XCTAssertEqual(jwt, "")
        
    }
    
    func testModels() throws {
        let modelo = HeroModelResponse(id: UUID(), favorite: false, name: "Batman", description: "El mejor", photo: "")
        XCTAssertNotNil(modelo)
        XCTAssertEqual(modelo.name, "Batman")
        
        let request = HeroModelRequest(name: "Goku")
        XCTAssertNotNil(request)
        
    }
    
    
    func testHeroFake() async throws  {
       let uc =  HerosUseCaseFake()
        XCTAssertNotNil(uc)
        let model = await uc.getHeros(name: "")
        XCTAssertNotNil(model)
        XCTAssertEqual(model.count, 2)
        
    }
    func testHeroReal() async throws  {
        let uc =  HerosUseCase(repo: DefaultHerosRepositoryFake())
         XCTAssertNotNil(uc)
         let model = await uc.getHeros(name: "")
         XCTAssertNotNil(model)
         XCTAssertEqual(model.count, 2)
    }

}
