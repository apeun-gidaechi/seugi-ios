import SwiftUI

public extension Font {
    enum SeugiFontSystem: SeugiFontable, CaseIterable {
        case display1
        case display2
        case title1
        case title2
        case subtitle1
        case subtitle2
        case body1
        case body2
        case caption1
        case caption2
    }

    static func seugi(_ style: SeugiFontSystem) -> Font {
        return style.font
    }
}

public extension Font.SeugiFontSystem {
    var font: Font {
        switch self {
        case .display1: Font(DesignSystemFontFamily.Pretendard.bold.font(size: 36))
        case .display2: Font(DesignSystemFontFamily.Pretendard.bold.font(size: 32))
        case .title1: Font(DesignSystemFontFamily.Pretendard.bold.font(size: 28))
        case .title2: Font(DesignSystemFontFamily.Pretendard.bold.font(size: 24))
        case .subtitle1: Font(DesignSystemFontFamily.Pretendard.semiBold.font(size: 20))
        case .subtitle2: Font(DesignSystemFontFamily.Pretendard.semiBold.font(size: 16))
        case .body1: Font(DesignSystemFontFamily.Pretendard.semiBold.font(size: 14))
        case .body2: Font(DesignSystemFontFamily.Pretendard.regular.font(size: 14))
        case .caption1: Font(DesignSystemFontFamily.Pretendard.semiBold.font(size: 12))
        case .caption2: Font(DesignSystemFontFamily.Pretendard.regular.font(size: 12))
        }
    }
}
