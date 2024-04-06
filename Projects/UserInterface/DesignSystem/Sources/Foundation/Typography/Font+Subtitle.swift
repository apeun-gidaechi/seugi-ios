//
//  SeugiFontSystem+Subtitle.swift
//  DesignSystem
//
//  Created by dgsw8th71 on 4/7/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import SwiftUI

public extension Font {
    struct SubTitle: SeugiTypography {
        public var size: CGFloat
        public var weight: Pretendard.Weight
        
        public static let s1 = Self.init(size: 20, weight: .semiBold)
        public static let s2 = Self.init(size: 16, weight: .semiBold)
    }
}
