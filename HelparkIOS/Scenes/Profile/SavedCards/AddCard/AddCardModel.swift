//
//  AddCardModel.swift
//  HelparkIOS
//
//  Created by Ali Gürkan Sevilmis on 1.06.2024.
//

import Foundation

struct AddCardModel: Codable {
    let userId: Int
    let cardName: String
    let cardAlias: String
    let cardNumber: String
    let cardDate: String
    let cvv: String
    let cardTypeId: Int
}

struct AddCardResponseModel: Codable {
    let message: String
}
