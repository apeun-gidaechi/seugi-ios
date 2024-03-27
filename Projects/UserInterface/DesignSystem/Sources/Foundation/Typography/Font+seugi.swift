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
        case .display1:
            DesignSystemFontFamily.Pretendard.bold.swiftUIFont(size: 36)
        case .display2: DesignSystemFontFamily.Pretendard.bold.swiftUIFont(size: 32)
        case .title1: DesignSystemFontFamily.Pretendard.bold.swiftUIFont(size: 28)
        case .title2: DesignSystemFontFamily.Pretendard.bold.swiftUIFont(size: 24)
        case .subtitle1: DesignSystemFontFamily.Pretendard.semiBold.swiftUIFont(size: 20)
        case .subtitle2: DesignSystemFontFamily.Pretendard.semiBold.swiftUIFont(size: 16)
        case .body1: DesignSystemFontFamily.Pretendard.semiBold.swiftUIFont(size: 14)
        case .body2: DesignSystemFontFamily.Pretendard.regular.swiftUIFont(size: 14)
        case .caption1: DesignSystemFontFamily.Pretendard.semiBold.swiftUIFont(size: 12)
        case .caption2: DesignSystemFontFamily.Pretendard.regular.swiftUIFont(size: 12)
        }
    }
}
