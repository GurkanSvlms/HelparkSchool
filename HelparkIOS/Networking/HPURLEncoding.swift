//
//  HPURLEncoding.swift
//  HelparkIOS
//
//  Created by Hasan Ali Şişeci on 3.02.2024.
//

import Foundation

enum HPURLEncoding {
    case queryString
    case none

    func encode(_ request: inout URLRequest, with parameters: Parameters) {
        switch self {
            /// In case we need to pass Query Params to GET / Rarely for POST requests too
        case .queryString:
            guard let url = request.url else { return }
            if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false),
                !parameters.isEmpty {

                urlComponents.queryItems = [URLQueryItem]()
                for (k, v) in parameters {
                    let queryItem = URLQueryItem(name: k, value: "\(v)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                    urlComponents.queryItems?.append(queryItem)
                }
                request.url = urlComponents.url
            }

            /// default case f
        case .none:
            break
        }
    }
}
