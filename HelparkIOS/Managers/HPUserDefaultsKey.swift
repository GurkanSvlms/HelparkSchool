//
//  HPUserDefaultsKey.swift
//  HelparkIOS
//
//  Created by Hasan Ali Şişeci on 4.02.2024.
//

import Foundation

enum HPUserDefaultsKey: String, CaseIterable {
    case favoriteCarParks

    var value: String {
        return rawValue
    }
}
