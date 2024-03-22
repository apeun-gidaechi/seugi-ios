//
//  AlimoButtonType.swift
//  Alimo
//
//  Created by dgsw8th71 on 1/3/24.
//  Copyright © 2024 tuist.io. All rights reserved.
//

import SwiftUI

enum SeugiButtonType {
    case primary
    case black
    case red
    case none
    
    var backgroundColor: Color {
        switch self {
        case .primary: .seugi(.primary(.p500))
        case .black: .seugi(.sub(.black))
        case .red: .seugi(.red(.r200))
        case .none: .seugi(.gray(.g100))
        }
    }
    
    var foregroundColor: Color {
        switch self {
        case .primary: .seugi(.sub(.black))
        case .black: .seugi(.sub(.white))
        case .red: .seugi(.red(.r500))
        case .none: .seugi(.gray(.g500))
        }
    }
}

