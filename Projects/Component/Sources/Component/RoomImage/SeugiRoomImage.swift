import SwiftUI
import Nuke
import NukeUI
import SwiftUIUtil

public struct SeugiRoomImage: View {
    
    var url: String?
    var type: SeugiRoomImageType
    let label: String
    
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
                /// - Success
                if let image = state.image {
                    image
                /// - Error
                } else if state.error != nil {
                    unavailableView
                /// Fetching
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
            /// NotFound Url
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