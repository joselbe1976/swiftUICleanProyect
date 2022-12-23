//
//  LoginView.swift
//  SwiftUICleanArqProyect
//
//  Created by jose.bustos.local on 22/12/22.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var appState: AppState
    
    @State private var user:String = ""
    @State private var pass:String = ""
    
    var body: some View {
        VStack{
            Form{
                TextField(text: $user) {
                    Text("Usuario")
                    
                }
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                
                TextField(text: $pass) {
                    Text("Clave")
                }
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                
                
                Button {
                    appState.loginApp(user: user, pass: pass)
                } label: {
                    Text("Login")
                    
                }

                if appState.statusLogin ==  .error {
                    Text("Error en el login")
                }
            }
           
           
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AppState())
    }
}
