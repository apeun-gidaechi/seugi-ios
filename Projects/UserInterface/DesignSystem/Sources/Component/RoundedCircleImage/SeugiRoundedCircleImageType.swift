import SwiftUI

public enum SeugiRoundedCircleImageType {
    case add
    case school
    case image
    case fill(image: SeugiImage)
    
    var image: Image {
        switch self {
        case .add: Image(icon: .addLine)
        case .school: Image(icon: .schoolFill)
        case .image: Image(icon: .imageLine)
        case let .fill(image): Image(image: image)
        }
    }
    
    func getImageSize(size: Size) -> CGFloat {
        switch (self, size) {
        case (.add, .large): 54
        case (.add, .small): 38
        case (.school, .large): 100
        case (.school, .small): 72
        case (.image, .large): 100
        case (.image, .small): 72
        case (.fill, .large): .infinity
        case (.fill, .small): .infinity
        }
    }
}

public extension SeugiRoundedCircleImageType {
    enum Size: CGFloat {
        case small = 128
        case large = 180
        
        var roundedCorner: CGFloat {
            switch self {
            case .small: 48
            case .large: 64
            }
        }
    }
}
