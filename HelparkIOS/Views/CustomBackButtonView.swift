//
//  CustomBackButtonView.swift
//  HelparkIOS
//
//  Created by Ali Gürkan Sevilmis on 30.01.2024.
//

import SwiftUI

struct CustomBackButtonView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image("left_arrow")
                    .resizable()
                    .frame(width: 18, height: 18)
            }
        }
    }
}
struct CustomBackButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CustomBackButtonView()
            .background(Color.gray)
    }
}

