//
//  RegisterViewModel.swift
//  HelparkIOS
//
//  Created by Ali Gürkan Sevilmis on 31.05.2024.
//

import Foundation
import Combine

class RegisterViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var error: Error?
    @Published var successMessage: String?
    @Published var goToHomeView = false
    
    // Register user function
    func registerUser(name: String, surname: String, email: String, phoneNumber: String) {
        // Create the model
        let user = RegisterModel(name: name, surname: surname, email: email, phoneNumber: phoneNumber)
        
        
        // Serialize model to JSON
        guard let jsonData = try? JSONEncoder().encode(user) else {
            self.error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid parameters"])
            return
        }
        
        // Create the URL
        guard let url = URL(string: "http://212.20.147.23/Auth/Register") else {
            self.error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            return
        }
        
        // Create the URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        // Show loading
        isLoading = true
        error = nil
        successMessage = nil
        
        // Perform the network request
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                // Hide loading
                self?.isLoading = false
                
                // Handle error
                if let error = error {
                    self?.error = error
                    return
                }
                
                // Handle response
                guard let data = data else {
                    self?.error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                    return
                }
                
                // Parse JSON response
                do {
                    let response = try JSONDecoder().decode(RegisterResponseModel.self, from: data)
                    self?.successMessage = response.message
                    self?.goToHomeView = true
                } catch {
                    self?.error = error
                }
            }
        }.resume()
    }
}
