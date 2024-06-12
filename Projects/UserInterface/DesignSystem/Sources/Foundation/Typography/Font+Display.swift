//
//  SeugiFontSystem+Headline.swift
//  DesignSystem
//
//  Created by dgsw8th71 on 4/7/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import SwiftUI

public extension Font {
    struct Display: SeugiTypography {
        public var size: CGFloat
        public var weight: Pretendard.Weight
        
        public static let d1 = Self.init(size: 36, weight: .bold)
        public static let d2 = Self.init(size: 32, weight: .bold)
    }
}
