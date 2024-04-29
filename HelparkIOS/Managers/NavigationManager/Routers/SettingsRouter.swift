//
//  SettingsRouter.swift
//  HelparkIOS
//
//  Created by Hasan Ali Şişeci on 3.02.2024.
//

import SwiftUI

struct SettingsRouter {
    let routes: SettingsRoutes

    @ViewBuilder
    func configure() -> some View {
        switch routes {
        case .settings:
            SettingsView()
        case .favorites:
            FavoritesView()
        case .agreement:
            AgreementView()
        case .about:
            AboutView()
        }
    }
}

enum SettingsRoutes: Hashable {
    case settings
    case favorites
    case agreement
    case about
}
