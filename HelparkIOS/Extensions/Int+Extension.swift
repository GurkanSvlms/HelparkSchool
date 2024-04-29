//
//  Int+Extension.swift
//  HelparkIOS
//
//  Created by Hasan Ali Şişeci on 4.02.2024.
//

import Foundation

extension Int {
    var unwrap: Int {
        return self != nil ? self : 0
    }
}
