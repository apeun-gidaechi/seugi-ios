//
//  SeugiFontSystem+Caption.swift
//  DesignSystem
//
//  Created by dgsw8th71 on 4/7/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import SwiftUI

public extension Font {
    
    struct Caption: SeugiTypography {
        public var size: CGFloat
        public var weight: Pretendard.Weight
        
        public static let c1 = Self.init(size: 12, weight: .semiBold)
        public static let c2 = Self.init(size: 12, weight: .regular)
    }
}
