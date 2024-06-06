//
//  HomeViewModel.swift
//  Helpark
//
//  Created by Ali Gürkan Sevilmis on 15.09.2023.
//

import SwiftUI
import MapKit
import CoreLocation

class HomeViewModel: ObservableObject {
    @Published var carParkList: [CarParkModel] = []
    @Published var districtList: [DistrictModel] = []
    @Published var carParkDetail: [CarParkDetailModel] = []
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = false
    @Published var searchText = ""
    @Published var lastTappedParkID: Int = 0
    @Published var selectedCarPark: CarParkModel? = nil
    @Published var showDetailCard: Bool = false
    @Published var showSearchSheet: Bool = false
    @Published var error: Error?
    @Published var successMessage: String?
    @Published var selectedDistrict: DistrictModel?
    @Published var updateMapView = false
    
    func fetchParks() {
        
        // Create the URL with query parameters
        var components = URLComponents()
        components.scheme = "http"
        components.host = "212.20.147.23"
        components.path = "/Park/ParkList"
        
        guard let url = components.url else {
            self.error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            return
        }
        
        // Create the URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
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
                    if httpResponse.statusCode == 200{
                    }
                    
                    // Log raw response data
                    let responseString = String(data: data, encoding: .utf8)
                    print("Response Data: \(responseString ?? "No response data")")
                    
                    // Parse JSON response
                    do {
                        let response = try JSONDecoder().decode([CarParkModel].self, from: data)
                        self?.carParkList = response
                    } catch {
                        // Log decoding error
                        print("JSON Decoding Error: \(error)")
                        self?.error = error
                    }
                }
            }
        }.resume()
    }
    func fetchParksByRadius(district: String?, lat: String, lng: String, radius: Double?) {
        

        // Create the URL with query parameters
        var components = URLComponents()
        components.scheme = "http"
        components.host = "212.20.147.23"
        components.path = "/Park/GetParksInRadius"
        components.queryItems = [
            URLQueryItem(name: "district", value: "a"),
                  URLQueryItem(name: "latitude", value: lat),
                  URLQueryItem(name: "longitude", value: lng),
                  URLQueryItem(name: "radius", value: String(radius ?? 5.0))
        ]
        
        guard let url = components.url else {
            self.error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            return
        }
        
        // Create the URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
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
                    if httpResponse.statusCode == 200{
                    }
                    
                    // Log raw response data
                    let responseString = String(data: data, encoding: .utf8)
                    print("Response Data: \(responseString ?? "No response data")")
                    
                    // Parse JSON response
                    do {
                        let response = try JSONDecoder().decode([CarParkModel].self, from: data)
                        self?.carParkList = response
                        self?.updateMapView = true
                    } catch {
                        // Log decoding error
                        print("JSON Decoding Error: \(error)")
                        self?.error = error
                    }
                }
            }
        }.resume()
    }
    
    func fetchDistrict(){
        // Create the URL with query parameters
        var components = URLComponents()
        components.scheme = "http"
        components.host = "212.20.147.23"
        components.path = "/Park/GetDistrict"
        
        guard let url = components.url else {
            self.error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            return
        }
        
        // Create the URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
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
                    if httpResponse.statusCode == 200{
                    }
                    
                    // Log raw response data
                    let responseString = String(data: data, encoding: .utf8)
                    print("Response Data: \(responseString ?? "No response data")")
                    
                    // Parse JSON response
                    do {
                        let response = try JSONDecoder().decode([DistrictModel].self, from: data)
                        self?.districtList = response
                        print(self?.districtList.count ?? "gfcjgfcxhgf")
                    } catch {
                        // Log decoding error
                        print("JSON Decoding Error: \(error)")
                        self?.error = error
                    }
                }
            }
        }.resume()
    }
}
