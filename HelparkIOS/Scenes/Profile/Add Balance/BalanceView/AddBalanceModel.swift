//
//  AddBalanceModel.swift
//  HelparkIOS
//
//  Created by Ali Gürkan Sevilmis on 2.06.2024.
//

import Foundation

struct AddBalanceRequestModel: Encodable {
    let id: Int
    let balance: Double
}

struct AddBalanceResponseModel: Decodable {
    let message: String
}
