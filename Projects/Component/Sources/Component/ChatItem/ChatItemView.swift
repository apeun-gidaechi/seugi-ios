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
        HStack(alignment: .top) {
            if case .other = type, config.isFirst {
                SeugiAvatar(author.picture, type: .medium)
            } else if case .ai = type, config.isFirst {
                SeugiAppIcon(type: .medium)
            }
            VStack(alignment: type.alignent.rawValue, spacing: 4) {
                if type.alignent == .leading && config.isFirst {
                    Text(author.name)
                        .font(.body(.b1))
                        .seugiColor(.gray(.g600))
                }
                ChatItemViewCell(text: config.message.message, type: type)
                    .addTimeLabel(alignment: type.alignent, config: config)
                    .padding(.leading, !config.isFirst && type.alignent == .leading ? 40 : 0)
            }
        }
        .padding(.horizontal, 8)
        .padding(.top, 8)
        .frame(maxWidth: .infinity, alignment: .init(horizontal: type.alignent.rawValue, vertical: .center))
    }
}
