//
//  HomeViewModel.swift
//  Helpark
//
//  Created by Ali Gürkan Sevilmis on 15.09.2023.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var carParkList: [CarParkModel] = []
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = false
    @Published var searchText = ""
    @Published var lastTappedParkID: UUID? = nil
    @Published var selectedCarPark: CarParkModel? = nil
    @Published var showDetailCard: Bool = false
    
    init() {
        fetchParks()
    }

    func fetchParks() {
        isLoading = true
        CarParkNetworkManager.instance.getCarParks { carParks, error in
            if let error {
                DispatchQueue.main.async {
                    self.errorMessage = "get car parks \(error.localizedDescription)"
                }
            } else {
                guard let carParks = carParks else { return }
                DispatchQueue.main.async {
                    self.carParkList = carParks
                    self.errorMessage = nil
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation {
                    self.isLoading = false
                }
            }
        }
    }
}
