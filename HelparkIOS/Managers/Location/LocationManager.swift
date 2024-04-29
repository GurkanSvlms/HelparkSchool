//
//  LocationCheckManager.swift
//  Helpark
//
//  Created by Ali Gürkan Sevilmis on 30.08.2023.
//

import Foundation
import CoreLocation
import Combine
import MapKit

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {

    private var locationManager = CLLocationManager()
    private var isFirstUpdate = true

    @Published var isLocationEnabled: Bool = false
    @Published var userLocation: CLLocationCoordinate2D?
    @Published var userDistrict: String?
    @Published var region = MKCoordinateRegion(
        center: .init(latitude: 37.7749, longitude: -122.4194),
        span: .init(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )

    override init() {
        super.init()
        setupLocationManager()
    }

    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        requestLocationAuthorization()
    }

    func requestLocationAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }

    func checkLocationServices() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManagerDidChangeAuthorization(self.locationManager)
                self.isLocationEnabled = true
            } else {
                self.isLocationEnabled = false
            }
            print("Location Enabled: \(self.isLocationEnabled)")
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        DispatchQueue.main.async {
            switch manager.authorizationStatus {
            case .authorizedWhenInUse, .authorizedAlways:
                self.isLocationEnabled = true
            case .notDetermined, .restricted, .denied:
                self.isLocationEnabled = false
            @unknown default:
                self.isLocationEnabled = false
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        DispatchQueue.main.async {
            if let location = locations.last?.coordinate {
                self.userLocation = location
                if self.isFirstUpdate {
                    self.updateRegionForLocation(location)
                    self.getDistrictForLocation(location)
                    self.isFirstUpdate = false
                    manager.stopUpdatingLocation()
                }
            }
        }
    }

    func updateRegionForLocation(_ location: CLLocationCoordinate2D) {
        DispatchQueue.main.async {
            self.region = MKCoordinateRegion(
                center: location,
                span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            )
        }
    }

    func getDistrictForLocation(_ location: CLLocationCoordinate2D) {
        DispatchQueue.main.async {
            let geocoder = CLGeocoder()
            let location = CLLocation(latitude: location.latitude, longitude: location.longitude)

            geocoder.reverseGeocodeLocation(location) { placemarks, error in
                if let placemark = placemarks?.first {
                    self.userDistrict = placemark.subAdministrativeArea
                }
            }
        }
    }

    func getDistrictsInCity(city: String, completion: @escaping ([String]?) -> Void) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = city
        let search = MKLocalSearch(request: request)

        search.start { (response, error) in
            guard let response = response, error == nil else {
                print("Error (getDistrictsInCity): \(error?.localizedDescription ?? "Unknown Error")")
                completion(nil)
                return
            }

            var districts: [String] = []

            for item in response.mapItems {
                if let locality = item.placemark.locality {
                    districts.append(locality)
                    print(districts)
                }
            }

            completion(districts)
        }
    }
}
