//
//  AddBalanceViewModel.swift
//  HelparkIOS
//
//  Created by Ali Gürkan Sevilmis on 2.06.2024.
//

import Foundation
import Combine

//
//  AddBalanceViewModel.swift
//  HelparkIOS
//
//  Created by Ali Gürkan Sevilmis on 2.06.2024.
//

import Foundation
import Combine

class AddBalanceViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var error: Error?
    @Published var successMessage: String?
    @Published var returnProfileView = false
    
    func addBalance(userId: Int, balance: Double) {
        let request = AddBalanceRequestModel(id: userId, balance: balance)
        
        guard let url = URL(string: "http://212.20.147.23/User/AddBalance") else {
            self.error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            return
        }
        
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = [
            URLQueryItem(name: "id", value: String(request.id)),
            URLQueryItem(name: "balance", value: String(request.balance))
        ]
        
        guard let finalURL = urlComponents?.url else {
            self.error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid final URL"])
            return
        }

        var urlRequest = URLRequest(url: finalURL)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("*/*", forHTTPHeaderField: "accept")
        
        isLoading = true
        error = nil
        successMessage = nil
        
        URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                if let error = error {
                    self?.error = error
                    print("Request error: \(error.localizedDescription)")
                    return
                }
                
                // Log HTTP status code
                if let httpResponse = response as? HTTPURLResponse {
                    print("HTTP Status Code: \(httpResponse.statusCode)")
                }
                
                guard let data = data else {
                    self?.error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                    return
                }
                
                // Log the raw response data
                if let responseString = String(data: data, encoding: .utf8) {
                    print("Response: \(responseString)")
                }
                
                do {
                    let response = try JSONDecoder().decode(AddBalanceResponseModel.self, from: data)
                    self?.successMessage = response.message
                    self?.returnProfileView = true
                } catch {
                    self?.error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "JSON decoding error: \(error.localizedDescription)"])
                    if let responseString = String(data: data, encoding: .utf8) {
                        print("JSON decoding error: \(error.localizedDescription). Response: \(responseString)")
                    }
                }
            }
        }.resume()
    }
}
