//
//  CardItemView.swift
//  HelparkIOS
//
//  Created by Ali Gürkan Sevilmis on 1.06.2024.
//

import SwiftUI

struct CardItemView: View {
    var cardName: String
    var cardNumber: String
    
    private var maskedCardNumber: String {
        let maskedCount = cardNumber.count - 4
        guard maskedCount > 0 else { return cardNumber }
        let maskedCharacters = String(repeating: "*", count: maskedCount)
        let visibleCharacters = cardNumber.suffix(4)
        return maskedCharacters + visibleCharacters
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 12) {
                    
                    Text(cardName)
                        .font(.popMediumSubheadline)
                        .foregroundColor(.gray)
                    
                    Text(maskedCardNumber)
                        .font(.popMediumSubheadline)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
                Spacer()
                
                Image("marterCard")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(Rectangle())
                    .padding(.top, 2)
            }
            .padding(12)
            .background(Color.white)
            .cornerRadius(15)
            .shadow(radius: 2)
        }
        .padding(.horizontal)
    }
}

struct CardItemView_Previews: PreviewProvider {
    static var previews: some View {
        CardItemView(cardName: "Gürkan İş", cardNumber: "12334123412341234")
    }
}
