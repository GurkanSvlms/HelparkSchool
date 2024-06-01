//
//  SavedCardsView.swift
//  HelparkIOS
//
//  Created by Ali Gürkan Sevilmis on 1.06.2024.
//

import SwiftUI

struct SavedCardsView: View {
    @StateObject var viewModel = ProfileMenuViewModel()
    @StateObject var deleteViewModel = SavedCardViewModel()
    @EnvironmentObject var navigationManager: NavigationManager
    @State private var userId = ""
    @State private var cardId = ""
    @State private var showDeletePopup = false

    var body: some View {
        ZStack{
            VStack {
                if viewModel.isLoading {
                    LoadingView()
                } else {
                    ScrollView {
                        VStack {
                            ForEach(viewModel.userCards, id: \.id) { card in
                                CardItemView(cardName: card.cardName, cardNumber: card.cardNumber)
                                    .onTapGesture {
                                        showDeletePopup = true
                                        cardId = String(card.id)
                                    }
                            }
                        }
                    }
                    Spacer()
                    
                    Button(action: {
                        navigationManager.navigate(.profile(.addCard))
                    }) {
                        Text("Kart Ekle")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 330)
                            .padding()
                            .background(Color("#3c7484"))
                            .cornerRadius(16)
                    }
                }
            }
            .navigationTitle("Kayıtlı Kartlarım")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: CustomBackButtonView())
            .onAppear{
                do {
                    try userId = HPUserDefaultsManager.shared.getModel(.userID, String.self)
                    viewModel.fetchUserData(userId: userId)
                    
                } catch {
                    print(HPUserDefaultsError.encodingFailed.localizedDescription)
                }
            }
            .onChange(of: deleteViewModel.deletedCardId) { deletedCardId in
                showDeletePopup = false
                viewModel.userCards.removeAll { $0.id == deletedCardId }
            }
            if showDeletePopup {
                PopupOneButton(
                    showPopup: $showDeletePopup,
                    title: "Kart Silme",
                    subtitle: "Kart Silme İşlemini Onaylıyor musunuz",
                    buttonText: "Evet",
                    showCloseButton: true) {
                        if let userIdString = try? HPUserDefaultsManager.shared.getModel(.userID, String.self),
                           let userId = Int32(userIdString) {
                            deleteViewModel.deleteCard(userId: userId, cardId: Int32(cardId) ?? 0)
                        }
                    }
            }

        }
    }
}

struct SavedCardsView_Previews: PreviewProvider {
    static var previews: some View {
        SavedCardsView()
    }
}
