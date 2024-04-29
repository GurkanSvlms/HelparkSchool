//
//  UIHelper.swift
//  HelparkIOS
//
//  Created by Hasan Ali Şişeci on 4.02.2024.
//

import UIKit

enum UI {
    enum Spacing {
        /// 0 pt
        static let p0: CGFloat = 0
        /// 4 pt
        static let p1: CGFloat = 4
        /// 8 pt
        static let p2: CGFloat = 8
        /// 12 pt
        static let p3: CGFloat = 12
        /// 16 pt
        static let p4: CGFloat = 16
        /// 20 pt
        static let p5: CGFloat = 20
        /// 24 pt
        static let p6: CGFloat = 24
        /// 28 pt
        static let p7: CGFloat = 28
        /// 32 pt
        static let p8: CGFloat = 32
        /// 36 pt
        static let p9: CGFloat = 36
        /// 40 pt
        static let p10: CGFloat = 40
        /// 44 pt
        static let p11: CGFloat = 44
        /// 48 pt
        static let p12: CGFloat = 48
        /// 52 pt
        static let p13: CGFloat = 52
        /// 56 pt
        static let p14: CGFloat = 56
        /// 60 pt
        static let p15: CGFloat = 60

        /// Same with p4 (16pt)
        static let defaultHorizontalSpacing: CGFloat = p4
        static let extraTopSpacing: CGFloat = 20
        static let extraBottomSpacing: CGFloat = 20

        enum Home {
            static let itemVerticalSpacing: CGFloat = 10
            static let sectionVerticalSpacing: CGFloat = 10
        }
    }

    enum Size {
        enum Screen {
            static let width: CGFloat = UIScreen.main.bounds.width
            static let height: CGFloat = UIScreen.main.bounds.height
        }

        enum StatusBar {
            static var height: CGFloat { SafeArea.insets.top }
        }

        enum SafeArea {
            static var insets: UIEdgeInsets {
                let keyWindow = UIApplication.shared.connectedScenes
                    .filter { $0.activationState == .foregroundActive }
                    .map { $0 as? UIWindowScene }
                    .compactMap { $0 }
                    .first?.windows
                    .filter { $0.isKeyWindow }.first
                return (keyWindow?.safeAreaInsets)!
            }
        }

        enum NavigationBar {
            static let height: CGFloat = 64
        }

        enum Home {
            static let bannerHeight: CGFloat = 138
            static let bannerHeightForGuest: CGFloat = 92
        }

        enum Button {
            static let defaultWidth: CGFloat = 214
            static let defaultHeight: CGFloat = 48
        }

        enum Alert {
            static let width: CGFloat = Screen.width - 48
        }

        enum Image {
            static let pebbleWidth: CGFloat = Screen.width * 0.4933
            static let pebbleHeight: CGFloat = Screen.height * 0.3485
            static let circleWidth: CGFloat = Screen.width * 0.58
        }
    }

    enum CornerRadius {
        /// 60 pt
        static let xxxLarge: CGFloat = 60
        /// 30 pt
        static let xxLarge: CGFloat = 30
        /// 20 pt
        static let xLarge: CGFloat = 20
        /// 16 pt
        static let large2: CGFloat = 16
        /// 12 pt
        static let large: CGFloat = 12
        /// 8 pt
        static let medium: CGFloat = 8
        /// 4 pt
        static let small: CGFloat = 4
    }
}
