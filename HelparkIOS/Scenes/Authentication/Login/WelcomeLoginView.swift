//
//  WelcomeLoginView.swift
//  HelparkIOS
//
//  Created by Ali Gürkan Sevilmis on 28.05.2024.
//

import SwiftUI

struct WelcomeLoginView: View {
    @StateObject private var viewModel = WelcomeLoginViewModel()
    @EnvironmentObject var navigationManager: NavigationManager
    
    @State private var phoneNumber = ""
    
    @State private var popupTitle = "Hata"
    @State private var popupSubtitle = "Giriş Yapmak İstediğiniz Telefon Numarası Bulunamamakta Lütfen Tekrar Deneyiniz"
    var body: some View {
        
        NavigationLink(
            destination: OtpView(phoneNumber: $phoneNumber),
            isActive: $viewModel.goToNextView)
        { EmptyView() }
        
        ZStack {
            VStack(alignment: .center){
                Image("helpark_title")
                    .resizable()
                    .frame(width: 300,height: 90)
                
                ValidationTextField(
                    text: $phoneNumber,
                    placeholder: "Telefon Numaranız",
                    fontColor: Color("#3c7484"))
                .padding(.top, 24)
                .keyboardType(.numberPad)
                .onChange(of: viewModel.showErrorPopup) { newValue in
                    if newValue{
                        phoneNumber.removeAll()
                    }
                }
                
                HStack{
                    Text("Kayıt olduğunuz numarayı başında 0 olmadan giriniz")
                        .foregroundColor(.black)
                        .font(.popRegularFootnote)
                        .padding(.leading, 4)
                    Spacer()
                }
                Button(action: {
                    viewModel.verifyPhoneNumber(phoneNumber: phoneNumber)
                }) {
                    Text("Giriş Yap")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 330)
                        .padding()
                        .background(Color("#3c7484"))
                        .cornerRadius(16)
                }
                .padding(.top, 20)
                .opacity(phoneNumber.isEmpty ? 0.5 : 1.0)
                .disabled(phoneNumber.isEmpty)
                
                Text("Kayıt Ol")
                    .foregroundColor(.black)
                    .font(.popSemiboldBody)
                    .padding(.top, 16)
                    .overlay(
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.black),
                        alignment: .bottom
                    )
                    .onTapGesture {
                        navigationManager.navigate(.home(.register))
                    }
            }
            .padding(.horizontal, 16)
            .navigationBarBackButtonHidden(true)
            .ignoresSafeArea()
            .onDisappear{
                viewModel.goToNextView = false
            }
            if viewModel.showErrorPopup {
                PopupOneButton(
                    title: popupTitle,
                    subtitle: popupSubtitle,
                    buttonText: "Tamam",
                    buttonAction: {
                        viewModel.showErrorPopup = false
                    }
                )
            }
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
}

#Preview {
    WelcomeLoginView()
}
