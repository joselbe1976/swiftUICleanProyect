//
//  SwiftUICleanArqProyectApp.swift
//  SwiftUICleanArqProyect
//
//  Created by jose.bustos.local on 22/12/22.
//

import SwiftUI

@main
struct SwiftUICleanArqProyectApp: App {
    let persistenceController = PersistenceController.shared  //instance of COreData
    let appState: AppState = AppState() //estado de la App
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext) //coreData as environment
                .environmentObject(appState)
        }
    }
}
 
