//
//  View+Extension.swift
//  HelparkIOS
//
//  Created by Hasan Ali Şişeci on 4.02.2024.
//

import SwiftUI

//MARK: For sheet top alignment
struct TopAlignedModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
    }
}

extension View {
    func topAligned() -> some View {
        self.modifier(TopAlignedModifier())
    }
}

//MARK: For card background with shadow
struct BackgroundWithShadowModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background { Color.white }
            .cornerRadius(UI.CornerRadius.large)
            .shadow(color: Color.gray.opacity(0.7), radius: 3, x: 0, y: 3)
    }
}

extension View {
    func backgroundWithShadow() -> some View {
        self.modifier(BackgroundWithShadowModifier())
    }
}
