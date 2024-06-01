//
//  ProfileMenuView.swift
//  HelparkIOS
//
//  Created by Ali Gürkan Sevilmis on 1.06.2024.
//

import SwiftUI

struct ProfileMenuView: View {
    
    @StateObject var viewModel = ProfileMenuViewModel()
    @State private var userId = ""
    var body: some View {
        VStack{
            ProfileMenuCardView(userName: viewModel.userName, userEmail: viewModel.userEmail, userPhoneNumber: viewModel.userPhoneNumber)
        }
        .navigationTitle("Profil Bilgilerim")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButtonView())
        .onAppear{
            do {
                try
                viewModel.fetchUserData(userId: HPUserDefaultsManager.shared.getModel(.userID, String.self))
            } catch {
                print(HPUserDefaultsError.encodingFailed.localizedDescription)
            }
        }
        
        
    }
}

#Preview {
    ProfileMenuView()
}
