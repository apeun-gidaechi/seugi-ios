import Foundation
import SwiftUI

import Domain
import SwiftUIUtil

import Nuke
import NukeUI

public struct ChatItemImageView: View {
    private let author: RetrieveMember
    private let type: ChatItemViewCellType
    private let config: ChatItemConfig
    
    public init(author: RetrieveMember, type: ChatItemViewCellType, config: ChatItemConfig) {
        self.author = author
        self.type = type
        self.config = config
    }
    
    private var imageUrl: String {
        config.message.message.split(separator: MessageConstant.fileSeparator).first.map(String.init) ?? ""
    }
    
    public var body: some View {
        ChatItemContainer(
            author: author,
            type: type,
            config: config
        ) {
            LazyImage(url: URL(string: imageUrl) ?? .aboutBlank) { state in
                if state.isLoading {
                    ProgressView()
                } else if let image = state.image {
                    image
                        .resizable()
                        .adjustFrame(minWidth: 128, maxWidth: 320, minHeight: 40, maxHeight: 300)
                }
            }
            .processors([.roundedCorners(radius: 12)])
            .addTimeLabel(alignment: type.alignent, config: config)
        }
    }
}
