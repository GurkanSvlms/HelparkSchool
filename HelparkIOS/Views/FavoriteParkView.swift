//
//  FavoriteParkView.swift
//  HelparkIOS
//
//  Created by Ali Gürkan Sevilmis on 3.06.2024.
//

import SwiftUI

struct FavoriteParkView: View {
    var parkName: String
    var parkLocation: String
    var parkState: Int
    
    var openOrClosedColor: Color {
        parkState == 0 ? .red : .green
    }
    
    var formattedParkLocation: String {
            if parkLocation.isEmpty {
                return parkLocation
            } else {
                let lowercasedLocation = parkLocation.lowercased()
                return lowercasedLocation.prefix(1).uppercased() + lowercasedLocation.dropFirst()
            }
        }
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text(parkName)
                        .font(.popMediumHeadline)
                        .foregroundColor(openOrClosedColor)
                        .multilineTextAlignment(.leading)
                    
                    Text(formattedParkLocation)
                        .font(.popMediumHeadline)
                        .foregroundColor(.gray)
                    
                }
                .padding(.horizontal)
                Spacer()
                
                Image("right_arrow")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 20, height: 20)
                    .foregroundColor(.black)
            }
            .padding(12)
            .background(Color.white)
            .cornerRadius(15)
            .shadow(radius: 2)
        }
        .padding(.horizontal)
        .padding(.top, 8)
    }
}

struct FavoriteParkView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteParkView(parkName: "Helpark Otopark", parkLocation: "Maltepe", parkState: 0)
    }
}
