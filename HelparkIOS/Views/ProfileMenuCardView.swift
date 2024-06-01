//
//  ProfileMenuCardView.swift
//  HelparkIOS
//
//  Created by Ali Gürkan Sevilmis on 1.06.2024.
//

import SwiftUI

struct ProfileMenuCardView: View {
    
    @Binding var userName: String
    @Binding var userEmail: String
    @Binding var userPhoneNumber: String
    
    var body: some View {
        HStack(alignment: .center) {
            Image("userPhoto")
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .foregroundColor(Color("#3c7484"))
            
            VStack(alignment: .leading, spacing: 0) {
                Text(userName)
                    .font(.popBoldTitle3)
                
                Text(userEmail)
                    .font(.popMediumSubheadline)
                    .foregroundColor(.gray)
                
                Text(userPhoneNumber)
                    .font(.popMediumSubheadline)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal)
            Spacer()
        }
        .padding(12)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 2)
    }
}

struct ProfileMenuCardView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileMenuCardView(userName: .constant("Gürkan Sevilmiş"), userEmail: .constant("gurkan@gmail.com"), userPhoneNumber: .constant("3948*0409*39"))
    }
}