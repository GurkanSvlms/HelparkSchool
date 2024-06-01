//
//  CarPlateViewModel.swift
//  HelparkIOS
//
//  Created by Ali Gürkan Sevilmis on 2.06.2024.
//

import Foundation
import Combine

class CarPlateViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var error: Error?
    @Published var errorMessage: String?
    @Published var successMessage: String?
    @Published var plateDeleted = false

    
    func deletePlate(carPlate: String) {
        guard let url = URL(string: "http://212.20.147.23/Car/ActiveOrDeactiveCarPlate?plate=\(carPlate)") else {
            self.errorMessage = "Invalid URL"
            self.error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        isLoading = true
        error = nil
        errorMessage = nil
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                if let error = error {
                    self?.error = error
                    self?.errorMessage = error.localizedDescription
                    return
                }
                
                guard let data = data else {
                    self?.errorMessage = "No data received"
                    self?.error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                    return
                }
                
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Received JSON String: \(jsonString)")
                } else {
                    print("Received data but could not convert to string")
                }
                
                // Decode the error response if exists
                if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                    self?.errorMessage = errorResponse.message
                    self?.error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: errorResponse.message])
                    return
                }
                
                // Decode the success response
                do {
                    let response = try JSONDecoder().decode(CarPlateResponseModel.self, from: data)
                    self?.successMessage = response.message
                    self?.plateDeleted = true
                } catch {
                    self?.errorMessage = "Failed to decode response"
                    self?.error = error
                }
            }
        }.resume()
    }
}

