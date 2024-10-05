import SwiftUI

public enum SeugiShadowSystem {
    case evBlack(EvBlack)
    case evPrimary(EvPrimary)
    case bottomNavigation(BottomNavigation)
}

public extension View {
    @ViewBuilder
    func shadow(_ shadow: SeugiShadowSystem? = nil) -> some View {
        if let shadow {
            switch shadow {
            case let .evBlack(shadowable as SeugiShadowable),
                let .evPrimary(shadowable as SeugiShadowable),
                let .bottomNavigation(shadowable as SeugiShadowable):
                self.shadow(color: shadowable.color, radius: shadowable.radius, x: shadowable.x, y: shadowable.y)
            }
        } else {
            self
        }
    }
}
