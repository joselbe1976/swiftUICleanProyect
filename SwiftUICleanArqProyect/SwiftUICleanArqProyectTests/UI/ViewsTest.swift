//
//  ViewsTest.swift
//  SwiftUICleanArqProyectTests
//
//  Created by jose.bustos.local on 23/12/22.
//

import XCTest
import SwiftUI
import ViewInspector //libreria en target de testing solo : https://github.com/nalexn/ViewInspector
@testable import SwiftUICleanArqProyect



//las vistas a testear se meten aqui
extension HomeView: Inspectable { }
extension HerosView: Inspectable { }
extension LoginView: Inspectable { }

final class ViewsTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testHomeView() async throws {
        //ViewMOdel del estado
        let vmAppState = AppState()
        XCTAssertNotNil(vmAppState)
        
        
        //definimos vista y le metemos el environment el viewModel
        let view = await HomeView().environmentObject(vmAppState)
        XCTAssertNotNil(view)
        
        //verificamos estado
        XCTAssertEqual(vmAppState.statusLogin, .none)
        //Cambio el estado
        vmAppState.statusLogin = .success
        XCTAssertEqual(vmAppState.statusLogin, .success)
        
        let bodyCuerpo = try! view.inspect().count
        XCTAssertNotNil(bodyCuerpo)
        
     
    }

    func testHerosView() async throws {
        let vm = HerosViewModel(useCase: HerosUseCaseFake())
        let view = HerosView(viewModel: vm)
        XCTAssertNotNil(view)
        
        await view.viewModel.getHeros()
        XCTAssertEqual(vm.herosData.count, 0)
        
        let obj =  try! view.inspect().find(viewWithId: 1)
        XCTAssertNotNil(obj)
        
        let bodyCuerpo = await view.body
        XCTAssertNotNil(bodyCuerpo)
        
    }

    func testLoginView() throws {
        let appstate = AppState()
        XCTAssertNotNil(appstate)
        
        let view = LoginView().environmentObject(appstate)
        XCTAssertNotNil(view)
        
        let form = try! view.inspect().find(viewWithId: 1)
        let button = try! view.inspect().find(viewWithId: 2)
        let textuser = try! view.inspect().find(viewWithId: 3)
        let textpass = try! view.inspect().find(viewWithId: 4)
        XCTAssertNotNil(form)
        XCTAssertNotNil(button)
        XCTAssertNotNil(textuser)
        XCTAssertNotNil(textpass)
     
    }

    
  
   

}
