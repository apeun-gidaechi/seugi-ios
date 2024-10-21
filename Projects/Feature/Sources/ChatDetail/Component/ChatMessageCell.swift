import SwiftUI
import Domain
import Component

struct ChatMessageCell: View {
    enum Action {
        case clickImage
        case downloadFile
    }
    
    @EnvironmentObject private var mainViewModel: MainViewModel
    
    private let message: Message
    private let action: (Action) -> Void
    
    init(
        message: Message,
        action: @escaping (Action) -> Void
    ) {
        self.message = message
        self.action = action
    }
    
    private var me: RetrieveMember? {
        mainViewModel.profile.data?.member
    }
    
    private var type: ChatItemAuthorType {
        if message.author?.id == me?.id {
            .me
        } else if message.type == .bot {
            .bot
        } else {
            .other
        }
    }
    
    var body: some View {
        switch message.viewType {
        case .text:
            ChatItemView(
                type: type,
                message: message
            )
        case .image:
            ChatItemImageView(
                type: type,
                message: message
            ) {
                action(.clickImage)
            }
        case .file:
            ChatItemFileView(
                type: type,
                message: message
            ) {
                action(.downloadFile)
            }
        case .detail:
            ChatItemDetailView(
                message: message
            )
        default:
            EmptyView()
        }
    }
}
