//
//  WelcomeLoginModel.swift
//  HelparkIOS
//
//  Created by Ali Gürkan Sevilmis on 1.06.2024.
//

import Foundation

struct WelcomeLoginModel: Codable {
    let phoneNumber: String
    
    func toQueryItems() -> [URLQueryItem] {
        return [
            URLQueryItem(name: "phoneNumber", value: phoneNumber),
        ]
    }
}

struct WelcomeLoginResponseModel: Codable {
    let message: String
}

