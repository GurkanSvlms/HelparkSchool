//
//  RezervationModel.swift
//  HelparkIOS
//
//  Created by Ali Gürkan Sevilmis on 6.06.2024.
//

import Foundation

import Foundation

// Rezervation model
struct RezervationModel: Codable {
    var userId: Int
    var carPlateId: Int
    var parkId: Int
    var resTime: Int
    var hire: Int
}

// Rezervation response model
struct RezervationResponseModel: Codable {
    var success: Bool
    var message: String?
}
