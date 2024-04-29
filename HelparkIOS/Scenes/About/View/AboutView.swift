//
//  AboutView.swift
//  HelparkIOS
//
//  Created by Ali Gürkan Sevilmis on 5.02.2024.
//

import SwiftUI

struct AboutView: View {
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: UI.Spacing.p4){
                Text(Strings.aboutText)
                    .font(.popLightCallout)
                Link(Strings.aboutLink, destination: URL(string: Strings.aboutLink)!)
                    .font(.popLightCallout)
            }
        }
        .padding(.horizontal)
        .scrollIndicators(.hidden)
        .navigationTitle("Hakkında")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButtonView())
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
