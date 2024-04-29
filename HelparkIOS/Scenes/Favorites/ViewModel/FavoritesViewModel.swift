//
//  FavoritesViewModel.swift
//  HelparkIOS
//
//  Created by Hasan Ali Şişeci on 4.02.2024.
//

import Foundation
import SwiftUI

class FavoritesViewModel: ObservableObject {
    @Published var carParks: [CarParkModel] = []
    @Published var selectedCarPark: CarParkModel = CarParkModel()
    @Published var carParkDetail: CarParkDetailModel = CarParkDetailModel()
    @Published var errorMessage: String? = nil

    @Published var isFavorite: Bool = false

    let userDefaults = HPUserDefaultsManager.shared

    init() {
        fetchFavoriteCarParks()
    }


    func fetchFavoriteCarParks(_ logEnabled: Bool = true) {
        do {
            carParks = try userDefaults.getModel(.favoriteCarParks, [CarParkModel].self)
        } catch {
            print(HPUserDefaultsError.decodingFailed.localizedDescription)
        }

        if logEnabled {
            print("fetched car parks: \(carParks)")
        } else {
            print("removed car parks: \(carParks)")
        }
    }

    func removeCarParkFromFavorite (at offset: IndexSet) {
        carParks.remove(atOffsets: offset)

        do {
            try userDefaults.setModel(key: .favoriteCarParks, model: carParks)
        } catch {
            print(HPUserDefaultsError.encodingFailed.localizedDescription)
        }

        fetchFavoriteCarParks(false)
    }
}
