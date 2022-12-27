//
//  DataTest.swift
//  SwiftUICleanArqProyectTests
//
//  Created by jose.bustos.local on 23/12/22.
//

import XCTest
@testable import SwiftUICleanArqProyect

final class DataTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testKeyChainLibrary()  throws  {
        
        let KC = KeyChain()
        XCTAssertNotNil(KC)
        
        let save = KC.saveKC(key: "Test", value: "123")
        XCTAssertEqual(save, true)
        
        let value = KC.loadKC(key: "Test")
        if let valor = value {
            XCTAssertEqual(valor, "123")
        }
    
        XCTAssertNoThrow(KC.deleteKC(key: "Test"))
    }
    
    func testNetWorkLogin() async throws  {
        
        let obj1 = NetworkLoginFake()
        XCTAssertNotNil(obj1)
        
        let obj2 = NetworkLogin()
        XCTAssertNotNil(obj2)
        
        let token1 = await obj1.loginApp(user: "", password: "")
        XCTAssertNotEqual(token1, "")
        
        //login Real error
        let token2 = await obj2.loginApp(user: "zzz", password: "zzzz")
        XCTAssertEqual(token2, "")
        
        
    }
    
    
    func testNetWorkHeros() async throws  {
        let obj1 = NetworkHerosFake()
        XCTAssertNotNil(obj1)
        let obj2 = NetworkHeros()
        XCTAssertNotNil(obj2)
        
        let data1 = await obj1.getHeros(name: "")
        XCTAssertNotNil(data1)
        
        
        //login de verdad y pedimos los heroes
        
        let login = NetworkLogin()
        let token = await login.loginApp(user: "bejl@babel.es", password: "abcdef")
        
        // guardamos en el keyChain
        let KC = KeyChain()
        XCTAssertNotNil(KC)
        KC.saveKC(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN, value: token)
        
        //lanzmaos la carga de heros
        let data2 = await obj2.getHeros(name: "")
        XCTAssertNotNil(data2)
        print("Datos real => \(data2.count)")
        
    }

}
