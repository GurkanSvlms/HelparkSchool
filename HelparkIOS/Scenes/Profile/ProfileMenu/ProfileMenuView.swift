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
    @State private var showDeletePopup = false

    let menuItems: [MenuModel] = [
        MenuModel(title: "Kartlarım", iconName: "card"),
        MenuModel(title: "Araçlarım", iconName: "car"),
        MenuModel(title: "Çıkış Yap", iconName: "logout")
    ]
    
    var body: some View {
        ZStack {
            VStack{
                if viewModel.isLoading {
                    LoadingView()
                } else {
                    ScrollView{
                        VStack{
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
                        }
                    }
                    Spacer()
                    
                    Button(action: {
                        showDeletePopup = true
                    }) {
                        Text("Kullanıcıyı Sil")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 330)
                            .padding()
                            .background(.red)
                            .cornerRadius(16)
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
            if showDeletePopup {
                PopupOneButton(
                    showPopup: $showDeletePopup,
                    title: "Kullanıcı Silme",
                    subtitle: "Kullanıcı Silme İşlemini Onaylıyor musunuz",
                    buttonText: "Evet",
                    showCloseButton: true) {
                        if let userIdString = try? HPUserDefaultsManager.shared.getModel(.userID, String.self),
                           let userId = Int32(userIdString) {
                            viewModel.deleteUser(userId: userId)
                        }
                    }
            }
        }
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
        .onChange(of: viewModel.userDeleted) {newValue in
            if newValue{
                showDeletePopup = false
                navigationManager.popToRoot()
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
