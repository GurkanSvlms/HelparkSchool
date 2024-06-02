//
//  WalletCardView.swift
//  HelparkIOS
//
//  Created by Ali Gürkan Sevilmis on 1.06.2024.
//

import SwiftUI

struct WalletCardView: View {
    
    @State var balance = ""
    var buttonAction: () -> Void
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text("Cüzdan Bakiyesi")
                        .font(.popMediumSubheadline)
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Button(action: {
                        // Detay Gör action
                    }) {
                        Text("Detay Gör")
                            .underline()
                            .font(.popMediumSubheadline)
                            .foregroundColor(Color("#3c7484"))
                    }
                }
                .padding(.horizontal)
                
                Text(balance + " ₺")
                    .font(.popMediumHeadline)
                    .foregroundColor(.black)
                    .padding(.horizontal)
                
                Button(action: {
                    buttonAction()
                }) {
                    HStack {
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                        Text("Bakiye Yükle")
                            .foregroundColor(.white)
                            .bold()
                    }
                    .frame(maxWidth: .infinity)
                    .padding(10)
                    .background(Color("#3c7484"))
                    .cornerRadius(10)
                }
                .padding(.horizontal)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(15)
        .shadow(radius: 2)
        }
        .padding(.horizontal)
    }
}
#Preview {
    WalletCardView(balance : "100", buttonAction: {
        
    })
}
