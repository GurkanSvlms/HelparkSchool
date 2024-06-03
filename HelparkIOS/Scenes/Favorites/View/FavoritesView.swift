//
//  FavoritesView.swift
//  HelparkIOS
//
//  Created by Hasan Ali Şişeci on 4.02.2024.
//

import SwiftUI

struct FavoritesView: View {
    @StateObject private var viewModel = FavoritesViewModel()
    @State private var userId: Int = 2

    var body: some View {
        VStack {
            if viewModel.isLoading {
                LoadingView()
            } else {
                if viewModel.parks.isEmpty{
                    EmptyViewComponent(message: "Kayıtlı otopark bulunamadı.")
                }
                else{
                    ScrollView {
                        VStack {
                            ForEach(viewModel.parks, id: \.id) { park in
                                FavoriteParkView(
                                    parkName: park.parkName,
                                    parkLocation: park.district,
                                    parkState: park.isOpen)
                                .onTapGesture {
                                    viewModel.showDetailCard = true
                                    viewModel.selectedCarPark = park
                                }
                            }
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $viewModel.showDetailCard) {
            if let selectedCarPark = viewModel.selectedCarPark {
                CarParkDetailView(homeViewModel: HomeViewModel(), carPark: selectedCarPark, showDeleteButton: true)
            }
        }
        .navigationTitle("Favori Otoparklarım")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButtonView())
        .onAppear{
            do {
                try viewModel.fetchFavouriteParks(userId:  Int(HPUserDefaultsManager.shared.getModel(.userID, String.self)) ?? 1)
                print(viewModel.parks.count)
            } catch {
                print(HPUserDefaultsError.encodingFailed.localizedDescription)
            }
        }
    }
}

struct FavouriteParksView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
