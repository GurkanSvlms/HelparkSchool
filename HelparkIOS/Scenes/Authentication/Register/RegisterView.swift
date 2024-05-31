//  RegisterView.swift
//  HelparkIOS
//
//  Created by Ali Gürkan Sevilmis on 31.05.2024.
//

import SwiftUI

struct RegisterView: View {
    
    @StateObject private var viewModel = RegisterViewModel()
    @EnvironmentObject var navigationManager: NavigationManager
    
    @State private var userName = ""
    @State private var userLastName = ""
    @State private var userMail = ""
    @State private var userPhoneNumber = ""
    
    @State private var showPopup = false
    @State private var popupTitle = ""
    @State private var popupSubtitle = ""
    
    @State private var smsAgreed = false
    @State private var emailAgreed = false
    
    private var buttonEnabled: Bool {
        !userName.isEmpty &&
        !userLastName.isEmpty &&
        !userMail.isEmpty &&
        !userPhoneNumber.isEmpty
    }
    
    var body: some View {
        VStack {
            ScrollView {
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
                    
                    CheckBoxView(
                        isMarked: $smsAgreed,
                        docText: .constant("SMS"),
                        forRegister: true)
                    
                    CheckBoxView(
                        isMarked: $emailAgreed,
                        docText: .constant("E-Posta"),
                        forRegister: true)
                    
                }
                .navigationTitle("Kayıt Ol")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: CustomBackButtonView())
                .padding(.horizontal)
                .padding(.top, 40)
                .onReceive(viewModel.$error) { error in
                    if let error = error {
                        popupTitle = "Hata"
                        popupSubtitle = error.localizedDescription
                        showPopup = true
                    }
                }
                .onChange(of: viewModel.goToHomeView, perform: { value in
                    if value{
                        navigationManager.navigate(.home(.home))
                    }
                })
            }
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
                .opacity(buttonEnabled ? 1.0 : 0.5)
                .disabled(!buttonEnabled)
            }
        }
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
}

#Preview {
    RegisterView()
}
