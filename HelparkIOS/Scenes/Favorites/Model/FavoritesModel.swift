//
//  FavoritesModel.swift
//  HelparkIOS
//
//  Created by Ali Gürkan Sevilmis on 2.06.2024.
//

import Foundation

struct GetFavouriteRequest: Codable {
    let userId: Int
}

struct GetFavouriteResponse: Codable {
    let parks: [CarParkModel]
}

struct FavoriteParkRequest: Codable {
    let userId: Int
    let parkId: Int
}

struct FavoriteParkResponse: Codable {
    let message: Bool
}
