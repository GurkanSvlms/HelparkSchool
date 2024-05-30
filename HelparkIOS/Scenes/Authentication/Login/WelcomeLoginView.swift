//
//  WelcomeLoginView.swift
//  HelparkIOS
//
//  Created by Ali Gürkan Sevilmis on 28.05.2024.
//

import SwiftUI

struct WelcomeLoginView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    @State private var passwordText = ""
    
    var body: some View {
        
        VStack(alignment: .center){
            Image("helpark_title")
                .resizable()
                .frame(width: 300,height: 90)
            
            ValidationTextField(
                text: $passwordText,
                placeholder: "Telefon Numaranız",
                fontColor: Color("#3c7484"))
            .padding(.top, 24)
            .keyboardType(.numberPad)
            
            HStack{
                Text("Kayıt olduğunuz numarayı başında 0 olmadan giriniz")
                    .foregroundColor(.black)
                    .font(.popRegularFootnote)
                    .padding(.leading, 4)
                Spacer()
            }
            Button(action: {
                
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
            .opacity(passwordText.isEmpty ? 0.5 : 1.0)
            .disabled(passwordText.isEmpty)
            
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
    }
}

#Preview {
    WelcomeLoginView()
}
