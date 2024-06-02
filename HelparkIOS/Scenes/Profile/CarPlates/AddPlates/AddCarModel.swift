//
//  AddCarModel.swift
//  HelparkIOS
//
//  Created by Ali Gürkan Sevilmis on 2.06.2024.
//

import Foundation

struct AddCarModel: Codable {
    let userId: Int
    let plate: String
    let model: String
    let fuelTypeId: Int
}

struct AddCarResponseModel: Codable {
    let message: String
}

