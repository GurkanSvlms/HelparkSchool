//
//  Routes.swift
//  HelparkIOS
//
//  Created by Hasan Ali Şişeci on 3.02.2024.
//

import Foundation

enum Routes: Hashable {
    case home(HomeRoutes)
    case settings(SettingsRoutes)
    case profile(ProfileRoutes)
}
