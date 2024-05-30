//
//  RegisterModel.swift
//  HelparkIOS
//
//  Created by Ali Gürkan Sevilmis on 31.05.2024.
//

import Foundation

struct RegisterModel: Codable {
    let name: String
    let surname: String
    let email: String
    let phoneNumber: String
}

struct RegisterResponseModel: Codable {
    let message: String
}
