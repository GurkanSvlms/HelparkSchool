//
//  ParkingRate.swift
//  HelparkIOS
//
//  Created by Hasan Ali Şişeci on 4.02.2024.
//

import Foundation

struct ParkingRate: Codable, Identifiable {
    var id = UUID()
    let timeRange: String
    let price: String
}
