//
//  FavoritesView.swift
//  HelparkIOS
//
//  Created by Hasan Ali Şişeci on 4.02.2024.
//

import SwiftUI

struct FavoritesView: View {
    @StateObject var viewModel = FavoritesViewModel()

    var body: some View {
        VStack {
            if viewModel.carParks.isEmpty {
                emptyState
            } else {
                list
            }
        }
            .background {
            Color.gray.opacity(0.2).ignoresSafeArea()
        }
            .scrollIndicators(.hidden)
            .navigationBarTitle("KAYITLI OTOPARKLAR")
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: CustomBackButtonView())

    }

    private var list: some View {
        List {
            ForEach(viewModel.carParks) { carPark in
                Button {
                    print(carPark.parkName)
                } label: {
                    favoritesRow(carPark)
                }
            }.onDelete(perform: delete)
        }.listStyle(GroupedListStyle())
    }

    private var emptyState: some View {
        VStack {
            Spacer()
            Image.detailAddFavImage
                .resizable()
                .frame(width: 60, height: 60)
                .aspectRatio(contentMode: .fit)
            Text("Henüz kayıtlı\notoparkınız yok.")
                .font(.popBoldTitle3)
                .multilineTextAlignment(.center)
            Spacer()
        }.frame(width: UI.Size.Screen.width)
    }

    private func delete(at offsets: IndexSet) {
        withAnimation {
            viewModel.removeCarParkFromFavorite(at: offsets)
        }
    }

    private func favoritesRow(_ carPark: CarParkModel) -> some View {
        HStack {
            Text(carPark.parkName)
                .font(.popRegularSubheadline)
                .multilineTextAlignment(.leading)
                .foregroundStyle(Color.black)
            Spacer()
        }
    }
}

#Preview {
    FavoritesView()
}
