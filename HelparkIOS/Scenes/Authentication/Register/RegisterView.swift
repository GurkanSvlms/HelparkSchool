//  RegisterView.swift
//  HelparkIOS
//
//  Created by Ali Gürkan Sevilmis on 31.05.2024.
//

import SwiftUI

struct RegisterView: View {
    
    @StateObject private var viewModel = RegisterViewModel()
    
    @State private var userName = ""
    @State private var userLastName = ""
    @State private var userMail = ""
    @State private var userPhoneNumber = ""
    
    @State private var showPopup = false
    @State private var popupTitle = ""
    @State private var popupSubtitle = ""
    
    private var buttonEnabled: Bool {
        !userName.isEmpty &&
        !userLastName.isEmpty &&
        !userMail.isEmpty &&
        !userPhoneNumber.isEmpty
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 16){
                
                ValidationTextField(
                    text: $userName,
                    placeholder: "İsim",
                    fontColor: Color("#3c7484"))
                
                ValidationTextField(
                    text: $userLastName,
                    placeholder: "Soyisim",
                    fontColor: Color("#3c7484"))
                
                ValidationTextField(
                    text: $userMail,
                    placeholder: "E-Posta",
                    fontColor: Color("#3c7484"))
                
                ValidationTextField(
                    text: $userPhoneNumber,
                    placeholder: "Telefon Numaranız",
                    fontColor: Color("#3c7484"))
                
                Spacer()
                
                if viewModel.isLoading {
                    ProgressView()
                        .padding()
                } else {
                    Button(action: {
                        viewModel.registerUser(
                            name: userName,
                            surname: userLastName,
                            email: userMail,
                            phoneNumber: userPhoneNumber)
                    }) {
                        Text("Kayıt Ol")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 330)
                            .padding()
                            .background(Color("#3c7484"))
                            .cornerRadius(16)
                    }
                    .padding(.top, 20)
                    .opacity(buttonEnabled ? 1.0 : 0.5)
                    .disabled(!buttonEnabled)
                }
            }
            .navigationTitle("Kayıt Ol")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: CustomBackButtonView())
            .ignoresSafeArea()
            .padding(.horizontal)
            .padding(.top, 40)
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            if showPopup {
                PopupOneButton(
                    title: popupTitle,
                    subtitle: popupSubtitle,
                    buttonText: "Tamam",
                    buttonAction: {
                        showPopup = false
                    }
                )
            }
        }
        .onReceive(viewModel.$error) { error in
            if let error = error {
                popupTitle = "Hata"
                popupSubtitle = error.localizedDescription
                showPopup = true
            }
        }
        .onReceive(viewModel.$successMessage) { successMessage in
            if let successMessage = successMessage {
                popupTitle = "Başarılı"
                popupSubtitle = successMessage.description
                showPopup = true
            }
        }
    }
}

#Preview {
    RegisterView()
}
