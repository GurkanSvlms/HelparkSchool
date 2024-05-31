//
//  AgreementView.swift
//  HelparkIOS
//
//  Created by Ali Gürkan Sevilmis on 4.02.2024.
//

import SwiftUI
import WebKit

struct AgreementView: View {
    @StateObject private var viewModel = AgreementViewModel()
    @Environment(\.presentationMode) var presentationMode


    @Binding var agreementMarked : Bool
    @Binding var forRegister : Bool
    var body: some View {
        WebView(urlString: viewModel.urlString)
            .edgesIgnoringSafeArea(.all)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: CustomBackButtonView())
        if forRegister{
            Spacer()
            
            Button(action: {
                agreementMarked.toggle()
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text(agreementMarked ? "Onaylamıyorum" : "Onaylıyorum")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 330)
                    .padding()
                    .background(Color("#3c7484"))
                    .cornerRadius(16)
            }
        }
        
    }
}

struct AgreementView_Previews: PreviewProvider {
    static var previews: some View {
        AgreementView(agreementMarked: .constant(false), forRegister: .constant(true))
    }
}
