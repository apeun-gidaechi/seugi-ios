import Foundation
import SwiftUI
import Domain
import SwiftUIUtil
import Nuke
import NukeUI

public struct ChatItemImageView: View {
    private let type: ChatItemAuthorType
    private let message: Message
    private let action: () -> Void
    
    public init(
        type: ChatItemAuthorType,
        message: Message,
        action: @escaping () -> Void
    ) {
        self.type = type
        self.message = message
        self.action = action
    }
    
    private var imageUrl: String {
        message.message.split(separator: MessageConstant.fileSeparator).first.map(String.init) ?? ""
    }
    
    public var body: some View {
        Button(action: action) {
            ChatItemContainer(
                type: type,
                message: message
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
                .addTimeLabel(alignment: type.alignent, message: message)
            }}
        
    }
}
