//
//  LoginView.swift
//  SwiftUICleanArqProyect
//
//  Created by jose.bustos.local on 22/12/22.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var appState: AppState
    
    @State private var user:String = "bejl@babel.es" //bejl@babel.es
    @State private var pass:String = "abcdef" //abcdef
    
    var body: some View {
        VStack{
            Form{
                TextField(text: $user) {
                    Text("Usuario")
                    
                }
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .id(3)
                
                TextField(text: $pass) {
                    Text("Clave")
                }
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .id(4)
                
                Button {
                    appState.loginApp(user: user, pass: pass)
                } label: {
                    Text("Login")
                    
                }
                .id(2)

                if appState.statusLogin ==  .error {
                    Text("Error en el login")
                }
            }
            .id(1)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AppState())
    }
}
