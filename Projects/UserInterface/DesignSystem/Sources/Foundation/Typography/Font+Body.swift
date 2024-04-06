//
//  SeugiFontSystem+Body.swift
//  DesignSystem
//
//  Created by dgsw8th71 on 4/7/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import SwiftUI

public extension Font {
    
    struct Body: SeugiTypography {
        public var size: CGFloat
        public var weight: Pretendard.Weight
        
        public static let b1 = Self.init(size: 14, weight: .semiBold)
        public static let b2 = Self.init(size: 14, weight: .regular)
    }
}
