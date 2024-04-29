//
//  SettingsView.swift
//  HelparkIOS
//
//  Created by Ali Gürkan Sevilmis on 30.01.2024.
//

import SwiftUI
import StoreKit

struct SettingsView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    @Environment(\.requestReview) var requestReview

    let menuItems: [MenuModel] = [
        MenuModel(title: Strings.savePark, iconName: "save", action: .favorites),
        MenuModel(title: Strings.agreement, iconName: "about", action: .agreement),
        MenuModel(title: Strings.about, iconName: "question", action: .about),
        MenuModel(title: Strings.rate, iconName: "rate")
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: UI.Spacing.p0) {
                ForEach(menuItems) { item in
                    Button {
                        switch item.action {
                        case .favorites:
                            navigationManager.navigate(.settings(.favorites))
                        case .agreement:
                            navigationManager.navigate(.settings(.agreement))
                        case .about:
                            navigationManager.navigate(.settings(.about))
                        case .rate:
                            requestReview()
                        case .none:
                            return
                        }
                    } label: {
                        MenuView(item: item, isLastItem: item == menuItems.last)
                            .listRowInsets(EdgeInsets())
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
        .padding(.vertical)
        .navigationBarTitle(Strings.settingTitle)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButtonView())
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
