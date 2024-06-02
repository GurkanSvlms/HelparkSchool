//
//  PopupOneButton.swift
//  Helpark
//
//  Created by Ali Gürkan Sevilmis on 12.09.2023.
//

import SwiftUI

struct PopupOneButton: View {
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var showPopup : Bool
    var title: String
    var subtitle: String
    var buttonText: String
    var showCloseButton = false
    var buttonAction: () -> Void
    
    var body: some View {
        ZStack {
            // Background overlay with blur effect
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.all)
                .blur(radius: 10)
            
            VStack {
                Text(title)
                    .font(.title)
                    .bold()
                    .padding(.bottom, 10)
                
                Text(subtitle)
                    .font(.subheadline)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 20)
                    .frame(height: 60)
                    .padding(.bottom, 24)
                
                VStack {
                    if showCloseButton{
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
                    }
                    
                    Button(action: {
                        showPopup = false
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
            .padding()
            .frame(width: 350, height: showCloseButton ? 280 : 230)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 10)
            .onAppear {
                hideKeyboard()
            }
        }
    }
}

struct PopupOneButton_Previews: PreviewProvider {
    static var previews: some View {
        PopupOneButton(
            showPopup: .constant(true),
            title: "Konum İzini",
            subtitle: "Konum izini olmadan uygulamamıza giriş yapılamamaktadır.",
            buttonText: "Ayarları Aç",showCloseButton: true,
            buttonAction: {}
        )
    }
}

// Hide keyboard function
func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
}
