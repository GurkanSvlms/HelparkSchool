//
//  HPNetworkRequestProtocol.swift
//  HelparkIOS
//
//  Created by Hasan Ali Şişeci on 3.02.2024.
//

import Foundation

protocol HPNetworkRequestProtocol {
    static func makeRequest<S: Codable>(session: URLSession, request: URLRequest, model: S.Type, onCompletion: @escaping(S?, HPNetworkError?) -> ())
    static func makeGetRequest<T: Codable> (path: String, queries: Parameters, onCompletion: @escaping(T?, HPNetworkError?) -> ())
    static func makePostRequest<T: Codable> (path: String, body: Parameters, onCompletion: @escaping (T?, HPNetworkError?) -> ())
}
