////
////  CarParkNetworkManager.swift
////  HelparkIOS
////
////  Created by Hasan Ali Şişeci on 3.02.2024.
////
//
//import Foundation
//
//struct CarParkNetworkManager {
//    static let instance = CarParkNetworkManager()
//
//    enum CarParkPath {
//        case carParks
//        case carParksDetail
//
//        var path: String {
//            switch self {
//            case .carParks:
//                return "/ispark/Park"
//            case .carParksDetail:
//                return "/ispark/ParkDetay"
//            }
//        }
//    }
//
//    func getCarParks(completion: @escaping ([CarParkModel]?, HPNetworkError?) -> ()) {
//        HPNetworkManager.makeGetRequest(path: CarParkPath.carParks.path, queries: [:]) { (result: [CarParkModel]?, error) in
//            completion(result, error)
//        }
//    }
//
//    func getCarParkDetail(id: String, completion: @escaping ([CarParkDetailModel]?, HPNetworkError?) -> ()) {
//        HPNetworkManager.makeGetRequest(path: CarParkPath.carParksDetail.path, queries: ["id": id]) { (result: [CarParkDetailModel]?, error) in
//            completion(result, error)
//        }
//    }
//}
