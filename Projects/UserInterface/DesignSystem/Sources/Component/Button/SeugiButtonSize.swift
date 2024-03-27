//
//  SeugiButtonSystem.swift
//  DesignSystem
//
//  Created by dgsw8th71 on 3/23/24.
//  Copyright © 2024 seugi. All rights reserved.
//

import SwiftUI

public enum SeugiButtonSize {
    case large
    case small
    
    var height: CGFloat {
        switch self {
        case .large: 54
        case .small: 36
        }
    }
    
    var font: Font {
        switch self {
        case .large: .seugi(.subtitle2)
        case .small: .seugi(.body2)
        }
    }
}
