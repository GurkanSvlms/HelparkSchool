//
//  HPSquareButton.swift
//  HelparkIOS
//
//  Created by Hasan Ali Şişeci on 3.02.2024.
//

import SwiftUI

struct HPSquareButton: View {
    let image: Image
    var showStroke: Bool = false
    var color: Color = .gray
    var lenght: CGFloat = 40
    var imageLength: CGFloat {
        lenght * 3 / 5
    }

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(Color.white)
                .shadow(radius: 2)
                .frame(width: lenght, height: lenght)
                .cornerRadius(8)
            image
                .resizable()
                .scaledToFit()
                .frame(width: imageLength, height: imageLength)
                .foregroundStyle(color)
        }
            .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(.blue.opacity(0.8), lineWidth: 2)
                .opacity(showStroke ? 1 : 0)
        )
    }
}

#Preview {
    ZStack {
        Color.gray.ignoresSafeArea()
        HPSquareButton(image: Image(systemName: "location.circle.fill"))
    }
}
