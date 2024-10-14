import SwiftUI

import Domain
import DateUtil
import SwiftUIUtil

public struct ChatItemView: View {
    private let type: ChatItemViewCellType
    private let message: Message
    
    public init(
        type: ChatItemViewCellType,
        message: Message
    ) {
        self.type = type
        self.message = message
    }
    
    public var body: some View {
        ChatItemContainer(
            type: type,
            message: message
        ) {
            ChatItemViewCell(
                text: message.message,
                type: type
            )
            .addTimeLabel(alignment: type.alignent, message: message)
        }
    }
}
