import SwiftUI
import SwiftUIUtil

public struct SeugiToolTip: View {
    
    private let type: SeugiToolTipType
    private let size: SeugiToolTipType.Size
    private let direction: SeugiToolTipType.Direction
    private let text: String
    
    public init(
        type: SeugiToolTipType,
        size: SeugiToolTipType.Size,
        direction: SeugiToolTipType.Direction,
        text: String
    ) {
        self.type = type
        self.size = size
        self.text = text
        self.direction = direction
    }
    
    public var body: some View {
        VStack(alignment: type.alignment, spacing: -1) {
            if direction == .top {
                makeImage()
            }
            Text(text)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .seugiBackground(.gray(.g700))
                .cornerRadius(8, corners: .allCorners)
                .font(.body(.b1))
                .seugiColor(.sub(.white))
            if direction == .bottom {
                makeImage()
            }
        }
    }
    
    func makeImage() -> some View {
        Image(polygon: extractPolygon())
            .if(type == .right) {
                $0.scaleEffect(x: -1, y: 1)
            }
            .if(direction == .bottom) {
                $0.scaleEffect(x: 1, y: -1)
            }
            .if(type == .left) {
                $0.padding(.leading, 16)
            }
            .if(type == .right) {
                $0.padding(.trailing, 16)
            }
    }
    
    func extractPolygon() -> SeugiPolygon {
        switch (type, size) {
        case (.left, .large), (.right, .large): .toolTipSideLarge
        case (.left, .small), (.right, .small): .toolTipSideSmall
        case (.center, .large): .toolTipCenterLarge
        case (.center, .small): .toolTipCenterSmall
        }
    }
}
