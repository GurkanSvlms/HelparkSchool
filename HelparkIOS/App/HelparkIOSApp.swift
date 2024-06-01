//
//  HelparkIOSApp.swift
//  HelparkIOS
//
//  Created by Ali Gürkan Sevilmis on 28.01.2024.
//

import SwiftUI

@main
struct HelparkIOSApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject private var navigationManager = NavigationManager()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navigationManager.routes) {
                SplashView()
                    .navigationDestination(for: Routes.self) { route in
                    switch route {
                    case .home(let homeRoutes):
                        HomeRouter(routes: homeRoutes).configure()
                    case .settings(let settingsRoutes):
                        SettingsRouter(routes: settingsRoutes).configure()
                    case .profile(let profileRoutes):
                        ProfileRouter(routes: profileRoutes).configure()
                    }
                }
            }
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(navigationManager)
        }
    }
}
