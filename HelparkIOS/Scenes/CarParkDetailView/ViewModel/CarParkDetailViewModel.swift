//
//  CarParkDetailViewModel.swift
//  HelparkIOS
//
//  Created by Hasan Ali Şişeci on 4.02.2024.
//

import SwiftUI

//class CarParkDetailViewModel: ObservableObject {
//    @Published var carPark: CarParkModel = CarParkModel.defaultCarPark
//    @Published var carParkDetail: CarParkDetailModel = CarParkDetailModel.defaultDetail
//    
//    @Published var errorMessage: String? = nil
//
//    @Published var isFavorite: Bool = false
//
//    let userDefaults = HPUserDefaultsManager.shared
//
//    init() {
//        isFavoriteCheck()
//    }
//
//
//    func fetchCarParkDetail(id: String) {
//        CarParkNetworkManager.instance.getCarParkDetail(id: id) { carParkDetail, error in
//            if let error {
//                DispatchQueue.main.async {
//                    self.errorMessage = "get car park detail \(error.localizedDescription)"
//                }
//            } else {
//                guard let carParkDetail = carParkDetail else { return }
//                DispatchQueue.main.async {
//                    guard let carParkDetail = carParkDetail.first else { return }
//                    self.carParkDetail = carParkDetail
//                    self.errorMessage = nil
//                }
//            }
//        }
//    }
//
//    func saveToFavorite() {
//        var favorites: [CarParkModel] = []
//        do {
//            favorites = try userDefaults.getModel(.favoriteCarParks, [CarParkModel].self)
//        } catch {
//            print(HPUserDefaultsError.decodingFailed.localizedDescription)
//        }
//
//        favorites.append(carPark)
//
//        do {
//            try userDefaults.setModel(key: .favoriteCarParks, model: favorites)
//        } catch {
//            print(HPUserDefaultsError.encodingFailed.localizedDescription)
//        }
//
//        isFavoriteCheck()
//    }
//
//    func removeFromFavorite () {
//        var favorites: [CarParkModel] = []
//
//        do {
//            favorites = try userDefaults.getModel(.favoriteCarParks, [CarParkModel].self)
//        } catch {
//            print(HPUserDefaultsError.decodingFailed.localizedDescription)
//        }
//
//        if let index = favorites.firstIndex(where: { $0.parkID == carPark.parkID }) {
//            favorites.remove(at: index)
//        }
//
//        do {
//            try userDefaults.setModel(key: .favoriteCarParks, model: favorites)
//        } catch {
//            print(HPUserDefaultsError.encodingFailed.localizedDescription)
//        }
//
//        isFavoriteCheck()
//    }
//
//    func isFavoriteCheck() {
//        var favorites: [CarParkModel] = []
//        do {
//            favorites = try userDefaults.getModel(.favoriteCarParks, [CarParkModel].self)
//        } catch {
//            print(HPUserDefaultsError.decodingFailed.localizedDescription)
//        }
//
//        isFavorite = favorites.contains { $0.parkID == self.carPark.parkID }
//    }
//}
//
//extension CarParkDetailViewModel {
//    var occupancyColor: Color {
//        occupancyCapacity > carParkDetail.capacity / 2 ? .red : .green
//    }
//
//    var occupancyCapacity: Int {
//        (carParkDetail.capacity) - (carParkDetail.emptyCapacity)
//    }
//}
