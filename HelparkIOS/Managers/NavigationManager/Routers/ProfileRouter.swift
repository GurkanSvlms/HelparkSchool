//
//  ProfileRouter.swift
//  HelparkIOS
//
//  Created by Ali Gürkan Sevilmis on 1.06.2024.
//

import SwiftUI

struct ProfileRouter {
    let routes: ProfileRoutes

    @ViewBuilder
    func configure() -> some View {
        switch routes {
        case .wallet:
            SettingsView()
        case .myCards:
            FavoritesView()
        case .myCars:
            AgreementView(agreementMarked: .constant(false), forRegister: .constant(false))
        }
    }
}

enum ProfileRoutes: Hashable {
    case wallet
    case myCards
    case myCars
}
