import SwiftUI

public extension Font {
    struct Display: SeugiTypography {
        public var size: CGFloat
        public var weight: Pretendard.Weight
        
        public static let d1 = Self.init(size: 36, weight: .bold)
        public static let d2 = Self.init(size: 32, weight: .bold)
    }
}
