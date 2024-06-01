//
//  PopupOneButton.swift
//  Helpark
//
//  Created by Ali Gürkan Sevilmis on 12.09.2023.
//

import SwiftUI

struct PopupOneButton: View {
    @Environment(\.presentationMode) var presentationMode

    var title: String
    var subtitle: String
    var buttonText: String
    var showCloseButton = false
    var buttonAction: () -> Void
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.3).edgesIgnoringSafeArea(.all)
            VStack {
                Text(title)
                    .font(.title)
                    .bold()
                    .padding(.bottom, 10)
                
                Text(subtitle)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                
                VStack {
                    Button(action: {
                        buttonAction()
                    }) {
                        Text(buttonText)
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(10)
                            .frame(maxWidth: .infinity)
                            .background(Color("#3c7484"))
                            .cornerRadius(10)
                    }
                    .padding(.top, 20)
                    
                    if showCloseButton{
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Kapat")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(10)
                                .frame(maxWidth: .infinity)
                                .background(Color("#3c7484"))
                                .cornerRadius(10)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .frame(width: 350, height: showCloseButton ? 250 : 200)
            .background(Color.white)
            .cornerRadius(20)
        }
        .onAppear{
            hideKeyboard()
        }
    }
}

struct PopupOneButton_Previews: PreviewProvider {
    static var previews: some View {
        PopupOneButton(title: "Konum İzini", subtitle: "Konum izini olmadan uygulamamıza giriş yapılamamaktadır.", buttonText: "Ayarları Aç", buttonAction: {})
    }
}
