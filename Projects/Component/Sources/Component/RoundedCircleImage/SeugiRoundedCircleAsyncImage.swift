import SwiftUI
import SwiftUIUtil
import NukeUI

public struct SeugiRoundedCircleAsyncImage: View {
    
    private let url: String?
    private let icon: SeugiIconography
    private let size: SeugiRoundedCircleImageType.Size
    
    private init(
        url: String?,
        icon: SeugiIconography = .imageLine,
        size: SeugiRoundedCircleImageType.Size
    ) {
        self.url = url
        self.icon = icon
        self.size = size
    }
    
    public var body: some View {
        if let url {
            LazyImage(url: .init(string: url)) { state in
                if let image = state.image {
                    image
                }
            }
            .processors([.resize(size: .init(width: size.rawValue, height: size.rawValue), unit: .pixels)])
            .frame(width: size.rawValue, height: size.rawValue)
            .stroke(size.rawValue * 16 / 45, content: Color.seugi(.gray(.g400)), lineWidth: 2)
            .cornerRadius(size.rawValue * 16 / 45, corners: .allCorners)
        } else {
            SeugiRoundedCircleImage(type: .icon(icon), size: size)
        }
    }
}

public extension SeugiRoundedCircleAsyncImage {
    
    static func large(url: String?) -> Self {
        .init(url: url, size: .large)
    }
    
    static func medium(url: String?) -> Self {
        .init(url: url, size: .medium)
    }
    
    static func small(url: String?) -> Self {
        .init(url: url, size: .small)
    }
    
    static func extraSmall(url: String?) -> Self {
        .init(url: url, size: .extraSmall)
    }
}
