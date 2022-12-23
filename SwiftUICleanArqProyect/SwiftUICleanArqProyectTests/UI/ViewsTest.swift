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



final class ViewsTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testHomeView() throws {
        //ViewMOdel del estado
        let vmAppState = AppState()
        XCTAssertNotNil(vmAppState)
        
        
        //definimos vista y le metemos el environment el viewModel
        let view = HomeView().environmentObject(vmAppState)
        XCTAssertNotNil(view)
        
        //verificamos estado
        XCTAssertEqual(vmAppState.statusLogin, .none)
        //Cambio el estado
        vmAppState.statusLogin = .success
        XCTAssertEqual(vmAppState.statusLogin, .success)
        
        //ejecutamos el boton de la vista
        let boton = try view.inspect().find(viewWithId: 1)
        XCTAssertNotNil(boton)
        try boton.button().tap() //ejecutamos elboton
        

        
    }

   

}
