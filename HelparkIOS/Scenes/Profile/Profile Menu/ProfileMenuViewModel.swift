//
//  ProfileMenuViewModel.swift
//  HelparkIOS
//
//  Created by Ali Gürkan Sevilmis on 1.06.2024.
//

import Foundation
import Combine

class ProfileMenuViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var error: Error?
    @Published var errorMessage: String?
    @Published var user: UserProfileModel?
    @Published var userName = ""
    @Published var userEmail = ""
    @Published var userPhoneNumber = ""
    @Published var userWalletBalance = 0.0
    @Published var showingError = false

    func fetchUserData(userId: String) {
        guard let url = URL(string: "http://212.20.147.23/User/GetAllDataFromUser/\(userId)") else {
            self.errorMessage = "Invalid URL"
            self.error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            self.showingError = true
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        // Show loading
        isLoading = true
        error = nil
        errorMessage = nil
        user = nil
        
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
                
                // Gelen data'yı print et
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Received JSON String: \(jsonString)")
                } else {
                    print("Received data but could not convert to string")
                }
                
                // Önce hata mesajını kontrol et
                if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                    self?.errorMessage = errorResponse.message
                    self?.error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: errorResponse.message])
                    self?.showingError = true
                    return
                }
                
                do {
                    // Başarılı veri alma ve decode etme
                    let user = try JSONDecoder().decode(UserProfileModel.self, from: data)
                    self?.user = user
                    self?.userName = (user.name + " " + user.surname)
                    self?.userEmail = user.email
                    self?.userPhoneNumber = user.phoneNumber
                    self?.userWalletBalance = user.balance
                } catch {
                    // JSON decode edilemedi
                    self?.error = error
                    self?.errorMessage = error.localizedDescription
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
}
