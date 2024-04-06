import SwiftUI

public extension Font {
    
    static func pretendard(_ style: SeugiTypography) -> Font {
        custom(style.weight.rawValue, size: style.size)
    }
    
    static func display(_ type: Font.Display) -> Font {
        pretendard(type)
    }
    
    static func title(_ type: Font.Title) -> Font {
        pretendard(type)
    }
    
    static func subtitle(_ type: Font.SubTitle) -> Font {
        pretendard(type)
    }
    
    static func body(_ type: Font.Body) -> Font {
        pretendard(type)
    }
    
    static func caption(_ type: Font.Caption) -> Font {
        pretendard(type)
    }
}
