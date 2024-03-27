//
//  AlimoBadgeType.swift
//  App
//
//  Created by dgsw8th71 on 1/7/24.
//  Copyright © 2024 b8nd. All rights reserved.
//

import SwiftUI

public enum SeugiBadgeType {
    case normal
    case number(Int)
    
    var size: CGFloat {
        switch self {
        case .normal: 12
        case .number: 20
        }
    }
}
