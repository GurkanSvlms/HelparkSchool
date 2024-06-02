//
//  EmptyView.swift
//  HelparkIOS
//
//  Created by Ali Gürkan Sevilmis on 2.06.2024.
//

import SwiftUI

struct EmptyViewComponent: View {
    var message = "Kayıt bulunamadı"
    
    var body: some View {
        VStack {
            Image(systemName: "tray")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .foregroundColor(.gray)
            Text(message)
                .font(.title)
                .foregroundColor(.gray)
                .padding(.top, 10)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}

struct EmptyViewComponent_Previews: PreviewProvider {
    static var previews: some View {
        EmptyViewComponent(message: "Kayıtlı kart bulunamadı")
    }
}
