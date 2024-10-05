import SwiftUI

public enum ToggleType {
    case `default`
    case checkbox(size: ToggleSize)
}

public enum ToggleSize: CGFloat, CaseIterable {
    case small = 16
    case medium = 20
    case large = 24
}
