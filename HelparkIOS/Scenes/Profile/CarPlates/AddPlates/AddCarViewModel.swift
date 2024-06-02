//
//  AddCarViewModel.swift
//  HelparkIOS
//
//  Created by Ali Gürkan Sevilmis on 2.06.2024.
//

import Foundation
import Combine

class AddCarViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var error: Error?
    @Published var successMessage: String?
    @Published var returnCarView = false
    
    func addCarFunction(userId: Int, plate: String, model: String, fuelTypeId: Int) {
        let car = AddCarModel(userId: userId, plate: plate, model: model, fuelTypeId: fuelTypeId)
        
        guard let jsonData = try? JSONEncoder().encode(car) else {
            self.error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid parameters"])
            return
        }
        
        guard let url = URL(string: "http://212.20.147.23/Car/AddPlate") else {
            self.error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        isLoading = true
        error = nil
        successMessage = nil
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
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
                    let response = try JSONDecoder().decode(AddCarResponseModel.self, from: data)
                    self?.successMessage = response.message
                    self?.returnCarView = true
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
