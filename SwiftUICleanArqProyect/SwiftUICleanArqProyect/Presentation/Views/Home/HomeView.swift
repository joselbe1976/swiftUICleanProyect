//
//  HomeView.swift
//  SwiftUICleanArqProyect
//
//  Created by jose.bustos.local on 22/12/22.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var appState: AppState
    
    var body: some View {
        VStack{
            
            NavigationStack{
                VStack{
                    // hero List
                    HerosView(viewModel: HerosViewModel())
                    
                    Divider()
                    
                    
                    // Close session button
                    Button {
                        appState.closeSessionUser()
                    } label: {
                        Text("Cerrar Session")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(Color.blue)
                            .cornerRadius(15.0)
                            .shadow(radius: 10.0, x: 20, y : 10)
                    }
                    .padding([.bottom],10)
                    .id(1)
                }
                .navigationTitle("Heros")
                .navigationBarTitleDisplayMode(.large)
            }
            

        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(AppState())
    }
}
