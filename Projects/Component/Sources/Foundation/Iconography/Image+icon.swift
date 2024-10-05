import SwiftUI

public extension Image {
    init(icon: SeugiIconography) {
        self = Image(icon.rawValue, bundle: .module)
    }
}
