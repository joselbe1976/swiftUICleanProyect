//
//  ViewModelsTest.swift
//  SwiftUICleanArqProyectTests
//
//  Created by jose.bustos.local on 23/12/22.
//

import XCTest
import Combine
@testable import SwiftUICleanArqProyect

final class ViewModelsTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAppStateViewModel() async throws  {
        
        //viewModel con el repo Fake
        let vm = AppState(loginUseCase: LoginUseCaseFake())
        XCTAssertNotNil(vm)
        
        //Control Login
        await vm.validateControlLogin()
        XCTAssertEqual(vm.statusLogin, .none)
        
        //login
        await vm.loginApp(user: "", pass: "")
        XCTAssertEqual(vm.statusLogin, .success)
        
        
        //login
        await vm.closeSessionUser()

        
    }
    
    func testViewRouterViewModel() async throws  {
        let vm = ViewRouter()
        XCTAssertNotNil(vm)
        
        XCTAssertEqual(vm.screen, .splash)
 
        
    }

}
