//
//  OtpViewModel.swift
//  HelparkIOS
//
//  Created by Ali Gürkan Sevilmis on 30.05.2024.
//

import Foundation
import Combine

class OtpViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var error: Error?
    @Published var successMessage: String?
    @Published var goToNextView = false
    @Published var startTimer = false
    @Published var userId = ""
    
    func verifyPhoneNumber(phoneNumber: String, otpCode: String) {
        // Create the model
        let otpModel = OtpModel(phoneNumber: phoneNumber, otp: otpCode)
        
        // Create the URL with query parameters
        var components = URLComponents()
        components.scheme = "http"
        components.host = "212.20.147.23"
        components.path = "/OTPVerification/Verify"
        components.queryItems = otpModel.toQueryItems()
        
        guard let url = components.url else {
            self.error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            return
        }
        
        // Create the URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
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
                
                // Log HTTP status code
                if let httpResponse = response as? HTTPURLResponse {
                    print("HTTP Status Code: \(httpResponse.statusCode)")
                    if httpResponse.statusCode == 200 {
                        self?.goToNextView = true
                    }
                }
                
                // Log raw response data
                let responseString = String(data: data, encoding: .utf8)
                print("Response Data: \(responseString ?? "No response data")")
                
                // Parse JSON response
                do {
                    let response = try JSONDecoder().decode(OtpResponseModel.self, from: data)
                    self?.userId = response.userId
                } catch {
                    // Log decoding error
                    print("JSON Decoding Error: \(error)")
                    self?.error = error
                }
            }
        }.resume()
    }

    
    // Send Otp
    func sendOtp(phoneNumber: String) {
        // Create the model
        let otpCodeModel = OtpCodeModel(phoneNumber: phoneNumber)
        
        // Create the URL
        var components = URLComponents()
        components.scheme = "http"
        components.host = "212.20.147.23"
        components.path = "/GenerateOtp"
        
        guard let url = components.url else {
            self.error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            return
        }
        
        // Create the URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(otpCodeModel)
            request.httpBody = jsonData
        } catch {
            self.error = error
            return
        }
        
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
                
                // Log HTTP status code
                if let httpResponse = response as? HTTPURLResponse {
                    print("HTTP Status Code: \(httpResponse.statusCode)")
                    if httpResponse.statusCode == 200{
                        self?.startTimer = true
                    }
                    else{
                        self?.startTimer = false
                    }
                }
                
                // Log raw response data
                let responseString = String(data: data, encoding: .utf8)
                print("Response Data: \(responseString ?? "No response data")")
                
                // Parse JSON response
                do {
                    let response = try JSONDecoder().decode(OtpCodeResponseModel.self, from: data)
                    self?.successMessage = response.message
                } catch {
                    // Log decoding error
                    print("JSON Decoding Error: \(error)")
                    self?.error = error
                }
            }
        }.resume()
    }
    
}
