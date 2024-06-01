import SwiftUI

struct SavedCardsView: View {
    @StateObject var viewModel = ProfileMenuViewModel()

    var body: some View {
        VStack {
            if viewModel.isLoading {
                LoadingView()
            } else {
                ScrollView {
                    VStack {
                        ForEach(viewModel.userCards, id: \.id) { card in
                            CardItemView(cardName: card.cardName, cardNumber: card.cardNumber)
                        }
                    }
                }
                Spacer()
                
                Button(action: {
                    
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
                try
                viewModel.fetchUserData(userId: HPUserDefaultsManager.shared.getModel(.userID, String.self))
            } catch {
                print(HPUserDefaultsError.encodingFailed.localizedDescription)
            }
        }
    }
}

struct SavedCardsView_Previews: PreviewProvider {
    static var previews: some View {
        SavedCardsView()
    }
}
