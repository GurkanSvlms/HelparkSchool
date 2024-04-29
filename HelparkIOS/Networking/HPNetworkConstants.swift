//
//  HPNetworkConstants.swift
//  HelparkIOS
//
//  Created by Hasan Ali Şişeci on 3.02.2024.
//

import Foundation

enum HPNetworkConstants {
    static var baseURL: String {
        let urlString = "api.ibb.gov.tr"
        var components = URLComponents()
        components.scheme = "https"
        components.host = urlString
        return components.string ?? ""
    }
}
