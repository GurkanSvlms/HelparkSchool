//
//  NavigationManager.swift
//  HelparkIOS
//
//  Created by Hasan Ali Şişeci on 3.02.2024.
//

import SwiftUI

final class NavigationManager: ObservableObject {
    @Published var routes = NavigationPath()

    func navigate(_ route: Routes) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.routes.append(route)
        }
    }

    func popToRoot() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.routes = NavigationPath()
        }
    }

    func pop() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.routes.removeLast()
        }
    }
}
