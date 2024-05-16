import SwiftUI
import Nuke
import NukeUI
import SwiftUIUtil

public struct SeugiAvatar: View {
    
    var url: String?
    var type: SeugiAvatarType
    
    public init(
        _ url: String? = nil,
        type: SeugiAvatarType
    ) {
        self.url = url
        self.type = type
    }
    
    public var body: some View {
        if let url {
            LazyImage(url: .init(string: url)) { state in
                if let image = state.image {
                    image
                } else if state.error != nil {
                    Circle()
                        .seugiColor(.gray(.g100))
                        .frame(width: type.size, height: type.size)
                        .overlay {
                            Image(icon: .personFill)
                                .resizable()
                                .renderingMode(.template)
                                .seugiColor(.gray(.g300))
                                .frame(width: type.size / 2, height: type.size / 2)
                        }
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
            Circle()
                .seugiColor(.primary(.p200))
                .frame(width: type.size, height: type.size)
                .overlay {
                    Image(icon: .personFill)
                        .resizable()
                        .renderingMode(.template)
                        .seugiColor(.primary(.p300))
                        .frame(width: type.size / 2, height: type.size / 2)
                }
        }
    }
}
