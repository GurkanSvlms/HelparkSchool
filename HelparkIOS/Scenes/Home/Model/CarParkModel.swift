//
//  CarParkModel.swift
//  Helpark
//
//  Created by Ali Gürkan Sevilmis on 15.09.2023.
//

import MapKit

import Foundation

struct CarParkDetailModel: Codable {
    let id: Int
    let parkId: Int
    let updateDate: String
    let workHours: String
    let monthlyFee: Double
    let tariff: String?
    let district: String
    let address: String
    let areaPolygon: String
    let hire: Double
    let resTime: Int

    enum CodingKeys: String, CodingKey {
        case id
        case parkId
        case updateDate
        case workHours
        case monthlyFee
        case tariff
        case district
        case address
        case areaPolygon
        case hire
        case resTime
    }
}

struct CarParkModel: Codable, Identifiable {
    let id: Int
    let parkName: String
    let lat: String
    let lng: String
    let capacity: Int
    let emptyCapacity: Int
    let workHours: String
    let parkType: String
    let freeTime: Int
    let district: String
    let isOpen: Int
    let isOpened: Bool
    let parkPoint: String
    let state: Int
    let parkDetail: CarParkDetailModel

    enum CodingKeys: String, CodingKey {
        case id
        case parkName
        case lat
        case lng
        case capacity
        case emptyCapacity
        case workHours
        case parkType
        case freeTime
        case district
        case isOpen
        case isOpened
        case parkPoint
        case state
        case parkDetail
    }
}

struct CarParkListModel: Codable {
    let parks: [CarParkModel]

    enum CodingKeys: String, CodingKey {
        case parks = "parkList"
    }
}

extension CarParkModel {
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: self.lat.toDouble(), longitude: self.lng.toDouble())
    }
}

extension CarParkModel {
    static let defaultCarPark = CarParkModel(
        id: 0,
        parkName: "",
        lat: "",
        lng: "",
        capacity: 0,
        emptyCapacity: 0,
        workHours: "",
        parkType: "",
        freeTime: 0,
        district: "",
        isOpen: 0,
        isOpened: false,
        parkPoint: "",
        state: 0,
        parkDetail: CarParkDetailModel(
            id: 0,
            parkId: 0,
            updateDate: "",
            workHours: "",
            monthlyFee: 0.0,
            tariff: "",
            district: "",
            address: "",
            areaPolygon: "",
            hire: 0.0,
            resTime: 0
        )
    )
}

extension CarParkDetailModel {
    static let defaultDetail = CarParkDetailModel(
        id: 0,
        parkId: 0,
        updateDate: "",
        workHours: "",
        monthlyFee: 0.0,
        tariff: "",
        district: "",
        address: "",
        areaPolygon: "",
        hire: 0.0,
        resTime: 0
    )
}
