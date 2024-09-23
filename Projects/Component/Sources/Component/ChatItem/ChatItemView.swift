import SwiftUI
import Domain
import DateUtil
import SwiftUIUtil

public struct ChatItemView: View {
    
    private let author: RetrieveMember
    private let type: ChatItemViewCellType
    private let config: ChatItemConfig
    
    public init(
        author: RetrieveMember,
        type: ChatItemViewCellType,
        config: ChatItemConfig
    ) {
        self.author = author
        self.type = type
        self.config = config
    }
    
    public var body: some View {
        ChatItemContainer(
            author: author,
            type: type,
            config: config
        ) {
            ChatItemViewCell(
                text: config.message.message,
                type: type
            )
            .addTimeLabel(alignment: type.alignent, config: config)
        }
    }
}
