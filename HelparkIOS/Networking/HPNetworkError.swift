//
//  NetworkError.swift
//  HelparkIOS
//
//  Created by Hasan Ali Şişeci on 3.02.2024.
//

import Foundation

enum HPNetworkError: Error {
    case noInternet
    case apiFailure
    case invalidResponse
    case decodingError
}
