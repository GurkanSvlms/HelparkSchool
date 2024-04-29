//
//  CarParkModel.swift
//  Helpark
//
//  Created by Ali Gürkan Sevilmis on 15.09.2023.
//

import MapKit

struct CarParkModel: Identifiable, Codable, Hashable {
    var id = UUID()
    let parkID: Int
    let parkName: String
    let latitude: String
    let longitude: String
    let capacity: Int
    let emptyCapacity: Int
    let workHours: String
    let parkType: String
    let freeTime: Int
    let district: String
    let isOpen: Int

    enum CodingKeys: String, CodingKey {
        case parkID
        case parkName
        case latitude = "lat"
        case longitude = "lng"
        case capacity
        case emptyCapacity
        case workHours
        case parkType
        case freeTime
        case district
        case isOpen
    }

    init(id: UUID = UUID(), parkID: Int = 0, parkName: String = "", latitude: String = "", longitude: String = "", capacity: Int = 0, emptyCapacity: Int = 0, workHours: String = "", parkType: String = "", freeTime: Int = 0, district: String = "", isOpen: Int = 0) {
        self.id = id
        self.parkID = parkID
        self.parkName = parkName
        self.latitude = latitude
        self.longitude = longitude
        self.capacity = capacity
        self.emptyCapacity = emptyCapacity
        self.workHours = workHours
        self.parkType = parkType
        self.freeTime = freeTime
        self.district = district
        self.isOpen = isOpen
    }
}

extension CarParkModel {
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: self.latitude.toDouble(), longitude: self.longitude.toDouble())
    }
}
