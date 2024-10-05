import SwiftUI

public extension Image {
    init(image: SeugiImage) {
        self = Image(image.rawValue, bundle: .module)
    }
}
