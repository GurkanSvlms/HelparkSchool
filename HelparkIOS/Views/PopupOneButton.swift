//
//  PopupOneButton.swift
//  Helpark
//
//  Created by Ali Gürkan Sevilmis on 12.09.2023.
//

import SwiftUI

struct PopupOneButton: View {
    var title: String
    var subtitle: String
    var buttonText: String
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
                
                Button(action: {
                    buttonAction()
                }) {
                    Text(buttonText)
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color("#3c7484"))
                        .cornerRadius(10)
                }
                .padding(.top, 20)
            }
            .frame(width: 300, height: 200)
            .background(Color.white)
            .cornerRadius(20)
        }
        .onAppear{
            hideKeyboard()
        }
    }
}

//struct PopupOneButton_Previews: PreviewProvider {
//    static var previews: some View {
//        PopupOneButton(title: "Konum İzini", subtitle: "Konum izini olmadan uygulamamıza giriş yapılamamaktadır.", buttonText: "Ayarları Aç")
//    }
//}
