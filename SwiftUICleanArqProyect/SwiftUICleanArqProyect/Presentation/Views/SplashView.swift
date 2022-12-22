//
//  SplashView.swift
//  SwiftUICleanArqProyect
//
//  Created by jose.bustos.local on 22/12/22.
//

import SwiftUI

struct SplashView: View {

    
    
    var body: some View {
        ZStack {
            
            LinearGradient(
                colors: [.gradientTop, .gradientBottom],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 0) {
                
                Image(decorative: "logo")
                    .resizable()
                    .scaledToFit()
                    .padding(.top, 60)
                    .padding(.horizontal, 32)
                
                Spacer()
                
                Image(decorative: "goku")
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                    .offset(x: 10)
                
                
            }
        }
       
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
