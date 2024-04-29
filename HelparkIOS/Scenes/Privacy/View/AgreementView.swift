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

    var body: some View {
        WebView(urlString: viewModel.urlString)
            .edgesIgnoringSafeArea(.all)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: CustomBackButtonView())
    }
}

struct AgreementView_Previews: PreviewProvider {
    static var previews: some View {
        AgreementView()
    }
}
