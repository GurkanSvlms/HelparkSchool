//
//  ProfileCardView.swift
//  HelparkIOS
//
//  Created by Ali Gürkan Sevilmis on 1.06.2024.
//

import SwiftUI

struct ProfileCardView: View {
    @EnvironmentObject var navigationManager: NavigationManager

    var body: some View {
        VStack {
            HStack {
                Image("userPhoto")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .foregroundColor(Color("#3c7484"))
                
                VStack(alignment: .leading) {
                    Text("Hoşgeldin")
                        .font(.headline)
                    
                    HStack {
                        Image("park_pin_red")
                            .resizable()
                            .frame(width: 20,height: 20)
                            .foregroundColor(.red)
                        Text("Istanbul")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                
                Spacer()
                
                Button(action: {
                    navigationManager.navigate(.settings(.settings))
                }) {
                    Image(systemName: "line.horizontal.3")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .padding()
                        .background(Color.white)
                        .clipShape(Rectangle())
                        .cornerRadius(16)
                        .shadow(radius: 2)
                        .foregroundColor(Color("#3c7484"))
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(15)
            .shadow(radius: 5)
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct ProfileCardView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileCardView()
    }
}
