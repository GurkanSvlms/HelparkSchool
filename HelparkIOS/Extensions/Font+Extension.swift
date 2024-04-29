//
//  Font+Extension.swift
//  HelparkIOS
//
//  Created by Hasan Ali Şişeci on 4.02.2024.
//

import SwiftUI

extension Font {
    static func custom(_ font: CustomFonts, relativeTo style: Font.TextStyle) -> Font {
        custom(font.rawValue, size: style.size, relativeTo: style)
    }

    enum CustomFonts: String {
        /// Graphik Font Family
        case popBlack = "Poppins-Black"
        case popBlackItalic = "Poppins-BlackItalic" //-
        case popBold = "Poppins-Bold"
        case popBoldItalic = "Poppins-BoldItalic" //-
        case popExtraBold = "Poppins-ExtraBold"
        case popExtraBoldItalic = "Poppins-ExtraBoldItalic"//-
        case popExtraLight = "Poppins-ExtraLight"
        case popExtraLightItalic = "Poppins-ExtraLightItalic"//-
        case popLight = "Poppins-Light"
        case popLightItalic = "Poppins-LightItalic"//-
        case popMedium = "Poppins-Medium"
        case popMediumItalic = "Poppins-MediumItalic"
        case popRegular = "Poppins-Regular"
        case popRegularItalic = "Poppins-Italic"
        case popSemibold = "Poppins-Semibold"
        case popSemiboldItalic = "Poppins-SemiboldItalic" //-
        case popThin = "Poppins-Thin"
        case popThinItalic = "Poppins-ThinItalic"

    }
}

extension Font.TextStyle {
    var size: CGFloat {
        switch self {
        case .largeTitle: return 64
        case .title: return 48
        case .title2: return 36
        case .title3: return 24
        case .headline: return 20
        case .body: return 18
        case .subheadline: return 16
        case .callout: return 14
        case .footnote: return 12
        case .caption: return 10
        case .caption2: return 8
        @unknown default:
            return 8
        }
    }
}

extension Font {
    /// Graphik Black 64
    static let popBlackLarge = custom(.popBlack, relativeTo: .largeTitle)
    /// Graphik Black 48
    static let popBlackTitle = custom(.popBlack, relativeTo: .title)
    /// Graphik Black 36
    static let popBlackTitle2 = custom(.popBlack, relativeTo: .title2)
    /// Graphik Black 24
    static let popBlackTitle3 = custom(.popBlack, relativeTo: .title3)
    /// Graphik Black 20
    static let popBlackHeadline = custom(.popBlack, relativeTo: .headline)
    /// Graphik Black 18
    static let popBlackBody = custom(.popBlack, relativeTo: .body)
    /// Graphik Black 16
    static let popBlackSubheadline = custom(.popBlack, relativeTo: .subheadline)
    /// Graphik Black 14
    static let popBlackCallout = custom(.popBlack, relativeTo: .callout)
    /// Graphik Black 12
    static let popBlackFootnote = custom(.popBlack, relativeTo: .footnote)
    /// Graphik Black 10
    static let popBlackCaption = custom(.popBlack, relativeTo: .caption)
    /// Graphik Black 8
    static let popBlackCaption2 = custom(.popBlack, relativeTo: .caption2)

    /// Graphik Bold 64
    static let popBoldLarge = custom(.popBold, relativeTo: .largeTitle)
    /// Graphik Bold 48
    static let popBoldTitle = custom(.popBold, relativeTo: .title)
    /// Graphik Bold 36
    static let popBoldTitle2 = custom(.popBold, relativeTo: .title2)
    /// Graphik Bold 24
    static let popBoldTitle3 = custom(.popBold, relativeTo: .title3)
    /// Graphik Bold 20
    static let popBoldHeadline = custom(.popBold, relativeTo: .headline)
    /// Graphik Bold 18
    static let popBoldBody = custom(.popBold, relativeTo: .body)
    /// Graphik Bold 16
    static let popBoldSubheadline = custom(.popBold, relativeTo: .subheadline)
    /// Graphik Bold 14
    static let popBoldCallout = custom(.popBold, relativeTo: .callout)
    /// Graphik Bold 12
    static let popBoldFootnote = custom(.popBold, relativeTo: .footnote)
    /// Graphik Bold 10
    static let popBoldCaption = custom(.popBold, relativeTo: .caption)
    /// Graphik Bold 8
    static let popBoldCaption2 = custom(.popBold, relativeTo: .caption2)

    /// Graphik Extra Light 64
    static let popExtraLightLarge = custom(.popExtraLight, relativeTo: .largeTitle)
    /// Graphik Extra Light 48
    static let popExtraLightTitle = custom(.popExtraLight, relativeTo: .title)
    /// Graphik Extra Light 36
    static let popExtraLightTitle2 = custom(.popExtraLight, relativeTo: .title2)
    /// Graphik Extra Light 24
    static let popExtraLightTitle3 = custom(.popExtraLight, relativeTo: .title3)
    /// Graphik Extra Light 20
    static let popExtraLightHeadline = custom(.popExtraLight, relativeTo: .headline)
    /// Graphik Extra Light 18
    static let popExtraLightBody = custom(.popExtraLight, relativeTo: .body)
    /// Graphik Extra Light 16
    static let popExtraLightSubheadline = custom(.popExtraLight, relativeTo: .subheadline)
    /// Graphik Extra Light 14
    static let popExtraLightCallout = custom(.popExtraLight, relativeTo: .callout)
    /// Graphik Extra Light 12
    static let popExtraLightFootnote = custom(.popExtraLight, relativeTo: .footnote)
    /// Graphik Extra Light 10
    static let popExtraLightCaption = custom(.popExtraLight, relativeTo: .caption)
    /// Graphik Extra Light 8
    static let popExtraLightCaption2 = custom(.popExtraLight, relativeTo: .caption2)

    /// Graphik Medium 64
    static let popMediumLarge = custom(.popMedium, relativeTo: .largeTitle)
    /// Graphik Medium 48
    static let popMediumTitle = custom(.popMedium, relativeTo: .title)
    /// Graphik Medium 36
    static let popMediumTitle2 = custom(.popMedium, relativeTo: .title2)
    /// Graphik Medium 24
    static let popMediumTitle3 = custom(.popMedium, relativeTo: .title3)
    /// Graphik Medium 20
    static let popMediumHeadline = custom(.popMedium, relativeTo: .headline)
    /// Graphik Medium 18
    static let popMediumBody = custom(.popMedium, relativeTo: .body)
    /// Graphik Medium 16
    static let popMediumSubheadline = custom(.popMedium, relativeTo: .subheadline)
    /// Graphik Medium 14
    static let popMediumCallout = custom(.popMedium, relativeTo: .callout)
    /// Graphik Medium 12
    static let popMediumFootnote = custom(.popMedium, relativeTo: .footnote)
    /// Graphik Medium 10
    static let popMediumCaption = custom(.popMedium, relativeTo: .caption)
    /// Graphik Medium 8
    static let popMediumCaption2 = custom(.popMedium, relativeTo: .caption2)

    /// Graphik Light 64
    static let popLightLarge = custom(.popLight, relativeTo: .largeTitle)
    /// Graphik Light 48
    static let popLightTitle = custom(.popLight, relativeTo: .title)
    /// Graphik Light 36
    static let popLightTitle2 = custom(.popLight, relativeTo: .title2)
    /// Graphik Light 24
    static let popLightTitle3 = custom(.popLight, relativeTo: .title3)
    /// Graphik Light 20
    static let popLightHeadline = custom(.popLight, relativeTo: .headline)
    /// Graphik Light 18
    static let popLightBody = custom(.popLight, relativeTo: .body)
    /// Graphik Light 16
    static let popLightSubheadline = custom(.popLight, relativeTo: .subheadline)
    /// Graphik Light 14
    static let popLightCallout = custom(.popLight, relativeTo: .callout)
    /// Graphik Light 12
    static let popLightFootnote = custom(.popLight, relativeTo: .footnote)
    /// Graphik Light 10
    static let popLightCaption = custom(.popLight, relativeTo: .caption)
    /// Graphik Light 8
    static let popLightCaption2 = custom(.popLight, relativeTo: .caption2)

    /// Graphik Regular 64
    static let popRegularLarge = custom(.popRegular, relativeTo: .largeTitle)
    /// Graphik Regular 48
    static let popRegularTitle = custom(.popRegular, relativeTo: .title)
    /// Graphik Regular 36
    static let popRegularTitle2 = custom(.popRegular, relativeTo: .title2)
    /// Graphik Regular 24
    static let popRegularTitle3 = custom(.popRegular, relativeTo: .title3)
    /// Graphik Regular 20
    static let popRegularHeadline = custom(.popRegular, relativeTo: .headline)
    /// Graphik Regular 18
    static let popRegularBody = custom(.popRegular, relativeTo: .body)
    /// Graphik Regular 16
    static let popRegularSubheadline = custom(.popRegular, relativeTo: .subheadline)
    /// Graphik Regular 14
    static let popRegularCallout = custom(.popRegular, relativeTo: .callout)
    /// Graphik Regular 12
    static let popRegularFootnote = custom(.popRegular, relativeTo: .footnote)
    /// Graphik Regular 10
    static let popRegularCaption = custom(.popRegular, relativeTo: .caption)
    /// Graphik Regular 8
    static let popRegularCaption2 = custom(.popRegular, relativeTo: .caption2)

    /// Graphik Semibold 64
    static let popSemiboldLarge = custom(.popSemibold, relativeTo: .largeTitle)
    /// Graphik Semibold 48
    static let popSemiboldTitle = custom(.popSemibold, relativeTo: .title)
    /// Graphik Semibold 36
    static let popSemiboldTitle2 = custom(.popSemibold, relativeTo: .title2)
    /// Graphik Semibold 24
    static let popSemiboldTitle3 = custom(.popSemibold, relativeTo: .title3)
    /// Graphik Semibold 20
    static let popSemiboldHeadline = custom(.popSemibold, relativeTo: .headline)
    /// Graphik Semibold 18
    static let popSemiboldBody = custom(.popSemibold, relativeTo: .body)
    /// Graphik Semibold 16
    static let popSemiboldSubheadline = custom(.popSemibold, relativeTo: .subheadline)
    /// Graphik Semibold 14
    static let popSemiboldCallout = custom(.popSemibold, relativeTo: .callout)
    /// Graphik Semibold 12
    static let popSemiboldFootnote = custom(.popSemibold, relativeTo: .footnote)
    /// Graphik Semibold 10
    static let popSemiboldCaption = custom(.popSemibold, relativeTo: .caption)
    /// Graphik Semibold 8
    static let popSemiboldCaption2 = custom(.popSemibold, relativeTo: .caption2)

    /// Graphik Thin 64
    static let popThinLarge = custom(.popThin, relativeTo: .largeTitle)
    /// Graphik Thin 48
    static let popThinTitle = custom(.popThin, relativeTo: .title)
    /// Graphik Thin 36
    static let popThinTitle2 = custom(.popThin, relativeTo: .title2)
    /// Graphik Thin 24
    static let popThinTitle3 = custom(.popThin, relativeTo: .title3)
    /// Graphik Thin 20
    static let popThinHeadline = custom(.popThin, relativeTo: .headline)
    /// Graphik Thin 18
    static let popThinBody = custom(.popThin, relativeTo: .body)
    /// Graphik Thin 16
    static let popThinSubheadline = custom(.popThin, relativeTo: .subheadline)
    /// Graphik Thin 14
    static let popThinCallout = custom(.popThin, relativeTo: .callout)
    /// Graphik Thin 12
    static let popThinFootnote = custom(.popThin, relativeTo: .footnote)
    /// Graphik Thin 10
    static let popThinCaption = custom(.popThin, relativeTo: .caption)
    /// Graphik Thin 8
    static let popThinCaption2 = custom(.popThin, relativeTo: .caption2)

    /// Graphik Thin 64
    static let popThinItalicLarge = custom(.popThinItalic, relativeTo: .largeTitle)
    /// Graphik Thin 48
    static let popThinItalicTitle = custom(.popThinItalic, relativeTo: .title)
    /// Graphik Thin 36
    static let popThinItalicTitle2 = custom(.popThinItalic, relativeTo: .title2)
    /// Graphik Thin 24
    static let popThinItalicTitle3 = custom(.popThinItalic, relativeTo: .title3)
    /// Graphik Thin 20
    static let popThinItalicHeadline = custom(.popThinItalic, relativeTo: .headline)
    /// Graphik Thin 18
    static let popThinItalicBody = custom(.popThinItalic, relativeTo: .body)
    /// Graphik Thin 16
    static let popThinItalicSubheadline = custom(.popThinItalic, relativeTo: .subheadline)
    /// Graphik Thin 14
    static let popThinItalicCallout = custom(.popThinItalic, relativeTo: .callout)
    /// Graphik Thin 12
    static let popThinItalicFootnote = custom(.popThinItalic, relativeTo: .footnote)
    /// Graphik Thin 10
    static let popThinItalicCaption = custom(.popThinItalic, relativeTo: .caption)
    /// Graphik Thin 8
    static let popThinItalicCaption2 = custom(.popThinItalic, relativeTo: .caption2)
}
