//
//  View+seugi.swift
//  DesignSystem
//
//  Created by dgsw8th71 on 3/23/24.
//  Copyright © 2024 seugi. All rights reserved.
//

import SwiftUI

public enum SeugiShadowSystem {
    case evBlack(EvBlack)
    case evPrimary(EvPrimary)
    case bottomNavigation(BottomNavigation)
}

public extension View {
    
    func shadow(_ shadow: SeugiShadowSystem) -> some View {
        switch shadow {
        case let .evBlack(shadowable as SeugiShadowable),
            let .evPrimary(shadowable as SeugiShadowable),
            let .bottomNavigation(shadowable as SeugiShadowable):
            self.shadow(color: shadowable.color, radius: shadowable.radius, x: shadowable.x, y: shadowable.y)
        }
    }
}