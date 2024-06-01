//
//  ProfileMenuModel.swift
//  HelparkIOS
//
//  Created by Ali Gürkan Sevilmis on 1.06.2024.
//

import Foundation

struct CarModel: Codable {
    let id: Int
    let userId: Int
    let plate: String
    let model: String
    let fuelTypeId: Int
    let description: String
    let active: Int
}

struct CardModel: Codable {
    // Card modeline ait alanlar burada tanımlanmalı
    let id: Int
    let cardNumber: String
    let expiryDate: String
    // Diğer alanlar
}

struct UserProfileModel: Codable {
    let id: Int
    let name: String
    let surname: String
    let email: String
    let phoneNumber: String
    let debt: Double
    let balance: Double
    let active: Int
    let carPlates: [CarModel]
    let card: [CardModel]
}

struct ErrorResponse: Codable {
    let message: String
}
