//
//  CarParkDetailModel.swift
//  HelparkIOS
//
//  Created by Hasan Ali Şişeci on 4.02.2024.
//

import Foundation

struct CarParkDetailModel: Codable {
    var locationName: String
    var parkID: Int
    var parkName: String
    let latitude: String
    let longitude: String
    var capacity, emptyCapacity: Int
    var updateDate, workHours, parkType: String
    var freeTime, monthlyFee: Int
    var tariff, district, address, areaPolygon: String

    enum CodingKeys: String, CodingKey {
        case locationName
        case parkID
        case parkName
        case latitude = "lat"
        case longitude = "lng"
        case capacity
        case emptyCapacity
        case updateDate
        case workHours
        case parkType
        case freeTime
        case monthlyFee
        case district
        case tariff
        case address
        case areaPolygon
    }

    init(locationName: String = "", parkID: Int = 0, parkName: String = "", latitude: String = "", longitude: String = "", capacity: Int = 0, emptyCapacity: Int = 0, updateDate: String = "", workHours: String = "", parkType: String = "", freeTime: Int = 0, monthlyFee: Int = 0, tariff: String = "", district: String = "", address: String = "", areaPolygon: String = "") {
        self.locationName = locationName
        self.parkID = parkID
        self.parkName = parkName
        self.latitude = latitude
        self.longitude = longitude
        self.capacity = capacity
        self.emptyCapacity = emptyCapacity
        self.updateDate = updateDate
        self.workHours = workHours
        self.parkType = parkType
        self.freeTime = freeTime
        self.monthlyFee = monthlyFee
        self.tariff = tariff
        self.district = district
        self.address = address
        self.areaPolygon = areaPolygon
    }
}
