//
//  RootView.swift
//  SwiftUICleanArqProyect
//
//  Created by jose.bustos.local on 22/12/22.
//

import SwiftUI

struct RootView: View {
    @StateObject var viewModelRouter : ViewRouter = ViewRouter()
    @EnvironmentObject private var appState: AppState
    
    var body: some View {
        Group{
            
            switch viewModelRouter.screen{
            case .splash :
                SplashView()
            case .login:
                LoginView()
                    .transition(.scale)
            case .home:
                HomeView()
                    .transition(.scale)
            }
            
        }
        .onAppear{
            //Controlamos la session
            appState.validateControlLogin()
        }
        .onChange(of: appState.statusLogin, perform: { newValue in
            if newValue != .success{
                withAnimation {
                    viewModelRouter.screen = .login
                }
            } else {
                //Succes the token is OK. Send to Home
                withAnimation {
                    viewModelRouter.screen = .home
                }
            }
        })
        .environmentObject(viewModelRouter) //inyectamos en entorno la viewRuter
        
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .environmentObject(AppState())
    }
}
