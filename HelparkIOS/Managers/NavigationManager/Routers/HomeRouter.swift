//
//  HomeRouter.swift
//  HelparkIOS
//
//  Created by Hasan Ali Şişeci on 3.02.2024.
//

import SwiftUI

struct HomeRouter {
    let routes: HomeRoutes

    @ViewBuilder
    func configure() -> some View {
        switch routes {
        case .onboarding:
            OnboardingView()
        case .home:
            HomeView()
        case .login:
            WelcomeLoginView()
        case .register:
            RegisterView()
        }
    }
}

enum HomeRoutes: Hashable {
    case onboarding
    case home
    case login
    case register
}
