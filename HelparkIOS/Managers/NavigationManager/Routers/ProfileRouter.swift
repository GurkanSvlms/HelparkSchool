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
            EmptyView()
        case .myCards:
            SavedCardsView()
        case .myCars:
            EmptyView()
        }
    }
}

enum ProfileRoutes: Hashable {
    case wallet
    case myCards
    case myCars
}
