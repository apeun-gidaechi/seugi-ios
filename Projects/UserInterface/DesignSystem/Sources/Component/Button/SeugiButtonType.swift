//
//  AlimoButtonType.swift
//  Alimo
//
//  Created by dgsw8th71 on 1/3/24.
//  Copyright © 2024 tuist.io. All rights reserved.
//

import SwiftUI

public enum SeugiButtonType: CaseIterable {
    case primary
    case black
    case red
    case transparent
    case shadow
    case gray
    
    var backgroundColor: Color {
        switch self {
        case .primary: .seugi(.primary(.p500))
        case .black: .seugi(.sub(.black))
        case .red: .seugi(.red(.r200))
        case .transparent: .seugi(.sub(.transparent))
        case .shadow: .seugi(.sub(.white))
        case .gray: .seugi(.gray(.g100))
        }
    }
    
    var disabledBackgroundColor: Color {
        switch self {
        case .primary: .seugi(.primary(.p100))
        case .black: .seugi(.gray(.g500))
        case .red: .seugi(.red(.r100))
        case .transparent: .seugi(.sub(.transparent))
        case .shadow: .seugi(.sub(.white))
        case .gray: .seugi(.gray(.g100))
        }
    }
    
    var foregroundColor: Color {
        switch self {
        case .primary: .seugi(.sub(.white))
        case .black: .seugi(.sub(.white))
        case .red: .seugi(.red(.r500))
        case .transparent: .seugi(.sub(.black))
        case .shadow: .seugi(.sub(.black))
        case .gray: .seugi(.gray(.g600))
        }
    }
    
    var disabledForegroundColor: Color {
        switch self {
        case .primary: .seugi(.sub(.white))
        case .black: .seugi(.sub(.white))
        case .red: .seugi(.red(.r300))
        case .transparent: .seugi(.sub(.black))
        case .shadow: .seugi(.gray(.g500))
        case .gray: .seugi(.gray(.g500))
        }
    }
}
