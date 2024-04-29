//
//  String+Extension.swift
//  HelparkIOS
//
//  Created by Hasan Ali Şişeci on 3.02.2024.
//

import Foundation

extension String {
    func toDouble() -> Double {
        return Double(self) ?? 0
    }

    func convertToParkingRateArray() -> [ParkingRate] {
        var parkingRates = [ParkingRate]()

        let pairs = self.components(separatedBy: ";")

        for pair in pairs {
            let components = pair.components(separatedBy: ":")
            if components.count == 2 {
                let timeRange = components[0].trimmingCharacters(in: .whitespacesAndNewlines)
                let price = components[1].trimmingCharacters(in: .whitespacesAndNewlines)
                let rate = ParkingRate(timeRange: timeRange, price: price)
                parkingRates.append(rate)
            }
        }
        return parkingRates
    }

    //MARK: For localizable
    func localized() -> String {
        return NSLocalizedString(
            self,
            tableName: "Localizable",
            bundle: .main,
            value: self,
            comment: self
        )
    }
}



