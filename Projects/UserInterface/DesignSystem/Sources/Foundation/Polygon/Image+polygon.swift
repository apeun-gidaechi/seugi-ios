import SwiftUI

public extension Image {
    
    init(polygon: SeugiPolygon) {
        self = Image(polygon.rawValue, bundle: .module)
    }
}
