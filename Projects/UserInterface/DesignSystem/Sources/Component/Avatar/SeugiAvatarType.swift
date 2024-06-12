//
//  AlimoAvatarType.swift
//  App
//
//  Created by dgsw8th71 on 2/3/24.
//  Copyright © 2024 b8nd. All rights reserved.
//

import SwiftUI

public enum SeugiAvatarType: CaseIterable {
    case extraSmall
    case small
    case medium
    case large
    case extraLarge
    case xxl
    
    var size: CGFloat {
        switch self {
        case .extraSmall: 16
        case .small: 24
        case .medium: 32
        case .large: 36
        case .extraLarge: 64
        case .xxl: 128
        }
    }
}
