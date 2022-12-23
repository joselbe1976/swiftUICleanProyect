//
//  OtherTest.swift
//  SwiftUICleanArqProyectTests
//
//  Created by jose.bustos.local on 23/12/22.
//

import XCTest
@testable import SwiftUICleanArqProyect

final class OtherTest: XCTestCase {
    
    @PersistenceKeyChain(key: "TestPruebaWarapper") var token

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }



    func testKeyChainWrapper() throws {
        //asignacion y control de asignacion del property al keychain
        token = "Hola" //asignacion y grabacion
        XCTAssertEqual(token, "Hola")
        
        token = "" //asignacion y grabacion
        XCTAssertEqual(token, "")

    }

}
