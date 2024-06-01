//
//  OtpModel.swift
//  HelparkIOS
//
//  Created by Ali Gürkan Sevilmis on 30.05.2024.
//

import Foundation

struct OtpModel: Codable {
    let phoneNumber: String
    let otp: String
    
    func toQueryItems() -> [URLQueryItem] {
        return [
            URLQueryItem(name: "phoneNumber", value: phoneNumber),
            URLQueryItem(name: "otp", value: otp)
        ]
    }
}

struct OtpResponseModel: Codable {
    let message: String
}
