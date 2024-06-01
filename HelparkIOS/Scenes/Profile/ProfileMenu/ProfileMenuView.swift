//
//  ProfileMenuView.swift
//  HelparkIOS
//
//  Created by Ali Gürkan Sevilmis on 1.06.2024.
//

import SwiftUI

struct ProfileMenuView: View {
    
    @StateObject var viewModel = ProfileMenuViewModel()
    @EnvironmentObject var navigationManager: NavigationManager
    
    @State private var showLogoutPopup = false
    let menuItems: [MenuModel] = [
        MenuModel(title: "Kartlarım", iconName: "card"),
        MenuModel(title: "Araçlarım", iconName: "car"),
        MenuModel(title: "Çıkış Yap", iconName: "logout")
    ]
    
    var body: some View {
        ZStack {
            VStack(spacing: 16){
                if viewModel.isLoading {
                    LoadingView()
                } else {
                    ScrollView{
                        ProfileMenuCardView(userName: $viewModel.userName, userEmail: $viewModel.userEmail, userPhoneNumber: $viewModel.userPhoneNumber)
                        
                        WalletCardView(balance: String(viewModel.userWalletBalance))
                        
                        ForEach(menuItems) { item in
                            Button {
                                handleMenuItemTap(item: item)
                            } label: {
                                MenuView(item: item, isLastItem: item == menuItems.last)
                                    .listRowInsets(EdgeInsets())
                            }
                        }
                        Spacer()
                    }
                }
            }
            if showLogoutPopup{
                PopupOneButton(showPopup: $showLogoutPopup,
                               title: "Çıkış Yap",
                               subtitle: "Çıkış yapmak istiyor musun?",
                               buttonText: "Çıkış Yap",
                               showCloseButton: true) {
                    navigationManager.popToRoot()
                }
            }
        }
        .padding(.horizontal)
        .navigationTitle("Profil Bilgilerim")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButtonView())
        .onAppear{
            do {
                try viewModel.fetchUserData(userId:  HPUserDefaultsManager.shared.getModel(.userID, String.self))
            } catch {
                print(HPUserDefaultsError.encodingFailed.localizedDescription)
            }
        }
    }
    private func handleMenuItemTap(item: MenuModel) {
        switch item.title {
        case "Kartlarım":
            navigationManager.navigate(.profile(.myCards))
        case "Araçlarım":
            navigationManager.navigate(.profile(.myCars))
        case "Çıkış Yap":
            showLogoutPopup = true
        default:
            break
        }
    }
}

#Preview {
    ProfileMenuView()
}
