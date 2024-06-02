//
//  CarParkDetailViewModel.swift
//  HelparkIOS
//
//  Created by Hasan Ali Şişeci on 4.02.2024.
//

import SwiftUI

class CarParkDetailViewModel: ObservableObject {
    @Published var carPark: CarParkModel = CarParkModel.defaultCarPark
    @Published var carParkDetail: CarParkDetailModel = CarParkDetailModel.defaultDetail
    
    @Published var errorMessage: String? = nil
    
    @Published var isFavorite: Bool = false
    
    
}


