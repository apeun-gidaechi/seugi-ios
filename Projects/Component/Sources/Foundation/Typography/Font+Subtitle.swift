import SwiftUI

public extension Font {
    struct SubTitle: SeugiTypography {
        public var size: CGFloat
        public var weight: Pretendard.Weight
        
        public static let s1 = Self.init(size: 20, weight: .bold)
        public static let s2 = Self.init(size: 16, weight: .semiBold)
    }
}
