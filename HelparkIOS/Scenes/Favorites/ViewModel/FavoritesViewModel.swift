//
//  FavoritesViewModel.swift
//  HelparkIOS
//
//  Created by Hasan Ali Şişeci on 4.02.2024.
//

import Foundation
import Combine

class FavoritesViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var error: Error?
    @Published var errorMessage: String?
    @Published var successMessage: String?
    @Published var parks: [CarParkModel] = []
    @Published var showingError = false
    @Published var showDetailCard = false
    @Published var selectedCarPark: CarParkModel?
    
    
    func fetchFavouriteParks(userId: Int) {
        guard let url = URL(string: "http://212.20.147.23/User/GetFavourite?userId=\(userId)") else {
            self.errorMessage = "Invalid URL"
            self.error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            self.showingError = true
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        isLoading = true
        error = nil
        errorMessage = nil
        parks = []
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                if let error = error {
                    self?.error = error
                    self?.errorMessage = error.localizedDescription
                    self?.showingError = true
                    return
                }
                
                guard let data = data else {
                    self?.errorMessage = "No data received"
                    self?.error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                    self?.showingError = true
                    return
                }
                
                // Print raw JSON data
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Received JSON String: \(jsonString)")
                } else {
                    print("Received data but could not convert to string")
                }
                
                do {
                    let response = try JSONDecoder().decode([CarParkModel].self, from: data)
                    self?.parks = response
                    print("Parsed Parks: \(response)")
                } catch let decodingError {
                    self?.error = decodingError
                    self?.errorMessage = decodingError.localizedDescription
                    self?.showingError = true
                    if let jsonString = String(data: data, encoding: .utf8) {
                        print("Failed to decode JSON: \(jsonString)")
                    } else {
                        print("Failed to decode data and could not convert to string")
                    }
                }
            }
        }.resume()
    }
    
    func addOrRemoveFavorite(request: FavoriteParkRequest) {
        isLoading = true
        error = nil
        errorMessage = nil
        successMessage = nil

        guard let url = URL(string: "http://212.20.147.23/User/AddOrRemoveFavourite") else {
            self.errorMessage = "Invalid URL"
            self.error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            self.showingError = true
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let requestBody = try JSONEncoder().encode(request)
            urlRequest.httpBody = requestBody
            print("Request: \(String(data: requestBody, encoding: .utf8) ?? "Invalid request body")")
        } catch {
            self.error = error
            self.errorMessage = error.localizedDescription
            self.showingError = true
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                if let error = error {
                    self?.error = error
                    self?.errorMessage = error.localizedDescription
                    self?.showingError = true
                    return
                }
                
                guard let data = data else {
                    self?.errorMessage = "No data received"
                    self?.error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                    self?.showingError = true
                    return
                }
                
                print("Response Data: \(String(data: data, encoding: .utf8) ?? "Invalid response data")")
                
                do {
                    let response = try JSONDecoder().decode(FavoriteParkResponse.self, from: data)
                    self?.successMessage = response.message
                } catch {
                    self?.error = error
                    self?.errorMessage = error.localizedDescription
                    self?.showingError = true
                }
            }
        }.resume()
    }
}
