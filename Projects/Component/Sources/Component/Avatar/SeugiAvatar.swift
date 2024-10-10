import SwiftUI

import SwiftUIUtil

import Nuke
import NukeUI

public struct SeugiAvatar: View {
    private let url: String?
    private let type: SeugiAvatarType
    
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
                    unavailableView
                }
            }
            .processors([.resize(size: .init(width: type.size, height: type.size), unit: .pixels)])
            .frame(width: type.size, height: type.size)
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
                Image(icon: .personFill)
                    .resizable()
                    .renderingMode(.template)
                    .seugiColor(.primary(.p300))
                    .frame(width: type.size / 2, height: type.size / 2)
            }
    }
}
