import SwiftUI

public extension Font {
    struct Title: SeugiTypography {
        public var size: CGFloat
        public var weight: Pretendard.Weight
        
        public static let t1 = Self.init(size: 28, weight: .bold)
        public static let t2 = Self.init(size: 24, weight: .bold)
    }
}
