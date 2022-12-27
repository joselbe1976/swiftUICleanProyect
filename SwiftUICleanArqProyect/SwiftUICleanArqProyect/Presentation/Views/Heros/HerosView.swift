//
//  HerosView.swift
//  SwiftUICleanArqProyect
//
//  Created by jose.bustos.local on 27/12/22.
//

import SwiftUI

struct HerosView: View {
    @StateObject var viewModel : HerosViewModel
    
    var body: some View {
        List{
            ForEach(viewModel.herosData){ hero in
               // Este Vstack habría que sacarlo a una HerosRowView. 
                VStack{
                    Text("\(hero.name)")
                        .font(.title2)
                    
                    AsyncImage(url: URL(string: hero.photo)) { Image in
                        Image
                            .resizable()
                            .frame(width: 300, height: 200)
                            .cornerRadius(20.0)
                        
                    } placeholder: {
                        Text("Cargando imagen...")
                    }

                }
            }
        }
        .id(1)
        .task {
            await viewModel.getHeros()
        }
    }

}

struct HerosView_Previews: PreviewProvider {
    static var previews: some View {
        HerosView(viewModel: HerosViewModel(useCase: HerosUseCaseFake())) //Fake
    }
}
