import SwiftUI

import SwiftUIUtil

import Nuke
import NukeUI

public struct SeugiRoomImage: View {
    private let url: String?
    private let type: SeugiRoomImageType
    private let label: String
    
    public init(
        _ url: String? = nil,
        type: SeugiRoomImageType,
        label: String
    ) {
        self.url = url
        self.type = type
        self.label = label
    }
    
    private var labelFont: Font {
        switch type {
        case .extraSmall: .caption(.c2)
        case .small: .caption(.c1)
        case .medium: .body(.b1)
        case .large: .subtitle(.s1)
        case .extraLarge: .title(.t1)
        case .xxl: .display(.d1)
        }
    }
    
    public var body: some View {
        if let url {
            LazyImage(url: .init(string: url)) { state in
                if let image = state.image {
                    image
                } else if state.error != nil {
                    unavailableView
                } else {
                    Circle()
                        .seugiColor(.gray(.g100))
                        .frame(width: type.size, height: type.size)
                        .shimmer()
                }
            }
            .processors([.resize(size: .init(width: type.size, height: type.size), unit: .pixels)])
            .clipShape(Circle())
        } else {
            unavailableView
        }
    }
    
    @ViewBuilder
    private var unavailableView: some View {
        Circle()
            .seugiColor(.primary(.p200))
            .frame(width: type.size, height: type.size)
            .overlay {
                Text(label)
                    .font(labelFont)
                    .seugiColor(.primary(.p700))
            }
    }
}
