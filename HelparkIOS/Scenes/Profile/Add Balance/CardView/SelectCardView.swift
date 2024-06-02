//
//  SelectCardView.swift
//  HelparkIOS
//
//  Created by Ali Gürkan Sevilmis on 2.06.2024.
//

import SwiftUI

struct SelectCardView: View {
    
    @State private var cardId = ""
    @Binding var cards : [CardModel]
    @Binding var showCardSelection : Bool
    @State private var showEnterBalance = false
    
    var body: some View {
        VStack {
            Text("Kart Seç")
                .font(.headline)
                .foregroundColor(.black)
                .padding(.top, 24)
            
            if cards.isEmpty{
                Spacer()
                EmptyViewComponent(message: "Kayıtlı kart bulunamadı")
            }
            else{
                ScrollView {
                    VStack {
                        ForEach(cards, id: \.id) { card in
                            CardItemView(cardName: card.cardName, cardNumber: card.cardNumber)
                                .onTapGesture {
                                    cardId = String(card.id)
                                    
                                }
                        }
                    }
                }
            }
            
            Spacer()
            Button(action: {
                withAnimation {
                    showEnterBalance = true
                }
            }) {
                Text("Devam Et")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 330)
                    .padding()
                    .background(Color("#3c7484"))
                    .cornerRadius(16)
            }
            .opacity(cardId != "" ? 1.0 : 0.5)
            .disabled(cardId == "")
        }
        .sheet(isPresented: $showEnterBalance, content: {
            AddBalanceView(
                showCardSelection: $showCardSelection,
                showEnterBalance: $showCardSelection)
                .presentationDetents([.height(200)])
                .topAligned()
        })
        .navigationBarHidden(true)
    }
}
