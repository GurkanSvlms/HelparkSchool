//
//  AnnotationView.swift
//  Helpark
//
//  Created by Ali Gürkan Sevilmis on 25.09.2023.
//

import SwiftUI
import MapKit

struct ParkAnnotationView: View {
    let isTapped: Bool
    let title: String

    var body: some View {
        ZStack {
            Image("park_pin_red")
                .resizable()
                .frame(width: 25, height: 25)
                .aspectRatio(contentMode: .fit)
            if isTapped {
                withAnimation(.easeInOut) {
                    Text(title)
                        .foregroundStyle(Color.black)
                        .font(.callout)
                        .padding(5)
                        .background(Color(.white))
                        .cornerRadius(10)
                        .opacity(1)
                        .offset(y: -30)
                        .lineLimit(1)
                        .fixedSize(horizontal: true, vertical: false)
                }
            }
        }
    }
}

struct ParkAnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        ParkAnnotationView(isTapped: true, title: "Uzun Bir Başlık Denemesi")
    }
}
