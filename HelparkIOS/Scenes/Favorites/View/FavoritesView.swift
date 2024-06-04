//
//  FavoritesView.swift
//  HelparkIOS
//
//  Created by Hasan Ali Şişeci on 4.02.2024.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel = FavoritesViewModel()
    @State private var userId: Int = 2

    var body: some View {
        NavigationLink(
            destination: CarParkDetailView(homeViewModel: HomeViewModel(), carPark: viewModel.selectedCarPark ?? CarParkModel.defaultCarPark, isExpanded: viewModel.showDetailCard, showDeleteButton: true),
            isActive: $viewModel.showDetailCard)
        { EmptyView() }
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
