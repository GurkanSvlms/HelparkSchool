//
//  ProfileMenuModel.swift
//  HelparkIOS
//
//  Created by Ali Gürkan Sevilmis on 1.06.2024.
//

import Foundation

enum FuelType: Int, Codable {
    case gasoline = 1
    case diesel = 2
    case electric = 3
    case hybrid = 4
    case lpg = 5
    case cng = 6
    case hydrogen = 7
    case unknown = 0

    var description: String {
        switch self {
        case .gasoline: return "Benzin"
        case .diesel: return "Dizel"
        case .electric: return "Elektrik"
        case .hybrid: return "Hibrit"
        case .lpg: return "LPG"
        case .cng: return "CNG"
        case .hydrogen: return "Hidrojen"
        case .unknown: return "Unknown"
        }
    }
}

struct CarPlate: Codable {
    let id: Int
    let userId: Int
    let plate: String
    let model: String
    let fuelTypeId: FuelType
    let description: String
    let active: Int
}

struct CardModel: Codable {
    let id: Int
    let userId: Int
    let cardName: String
    let cardAlias: String
    let cardNumber: String
    let cardDate: String
    let cvv: String
    let active: String
    let cardTypeId: Int
    let description: String
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
    let carPlates: [CarPlate]
    let card: [CardModel]
}

struct ErrorResponse: Codable {
    let message: String
}
