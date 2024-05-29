//
//  WelcomeLoginView.swift
//  HelparkIOS
//
//  Created by Ali Gürkan Sevilmis on 28.05.2024.
//

import SwiftUI

struct WelcomeLoginView: View {
    
    @State private var passwordText : String
    
    var body: some View {
        VStack{
            VStack(spacing: 0){
               
                ValidationTextField(
                    text: $passwordText,
                    placeholder: "Şifreni Gir",
                    fontColor: .black)
                .padding(.horizontal, 10)
                .padding(.top, 21)
                               
                HStack(spacing:0){
                    Button("Giriş Yap") {
                        
                    }
                    Spacer()
                      
                    Button("Kayıt Ol") {
                        
                    }

                    
                }
                .padding(.horizontal,-15)
                Spacer()
            }
        }
    }
}

#Preview {
    WelcomeLoginView()
}
