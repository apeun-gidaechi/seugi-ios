import SwiftUI
import Component
import Domain
import DateUtil

struct NotificationCell: View {
    
    enum Action {
        case updateNotification
        case removeNotification
        case reportNotification
        case addEmoji
        case emojiClicked(String)
    }
    
    private let profileId: Int
    private let notification: Domain.Notification
    private let action: (Action) -> Void
    
    init(
        profileId: Int,
        notification: Domain.Notification,
        action: @escaping (Action) -> Void
    ) {
        self.profileId = profileId
        self.notification = notification
        self.action = action
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("\(notification.userName) · \(notification.creationDate?.parseString("M월 d일 EEEE") ?? "")")
                    .seugiColor(.gray(.g600))
                    .font(.body(.b2))
                Spacer()
                Menu {
                    Button("공지 신고") {
                        action(.reportNotification)
                    }
                    if profileId == notification.userId {
                        Button("공지 수정") {
                            action(.updateNotification)
                        }
                        Button("공지 삭제", role: .destructive) {
                            action(.removeNotification)
                        }
                    }
                } label: {
                    Image(icon: .detailVerticalLine)
                        .resizable()
                        .renderingMode(.template)
                        .seugiColor(.gray(.g500))
                        .frame(width: 24, height: 24)
                }
                .onTapGesture {} // for stop propagation
            }
            VStack(alignment: .leading, spacing: 0) {
                Text(notification.title)
                    .multilineTextAlignment(.leading)
                    .seugiColor(.sub(.black))
                    .font(.subtitle(.s2))
                Text(notification.content)
                    .font(.body(.b2))
                    .multilineTextAlignment(.leading)
                    .seugiColor(.sub(.black))
            }
            HStack(spacing: 6) {
                Image(icon: .addEmoji)
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 28, height: 28)
                    .seugiColor(.gray(.g600))
                    .padding(4)
                    .button {
                        action(.addEmoji)
                    }
                    .padding(.trailing, 4)
                ForEach(notification.emoji.indices, id: \.self) { index in
                    let emoji = notification.emoji[index]
                    let selected = emoji.userList.contains(profileId)
                    HStack(spacing: 4) {
                        Text(emoji.emoji)
                            .font(.subtitle(.s2))
                        Text("\(emoji.userList.count)")
                            .font(.body(.b1))
                            .seugiColor(.gray(.g600))
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .seugiBackground(
                        selected
                        ? .primary(.p100)
                        : .gray(.g100),
                        in: RoundedRectangle(cornerRadius: 8)
                    )
                    // TODO: Add stroke
                    .button {
                        action(.emojiClicked(emoji.emoji))
                    }
                    .applyAnimation()
                }
                Spacer()
            }
        }
        .padding(12)
        .seugiBackground(.sub(.white))
        .cornerRadius(8)
        .shadow(.evBlack(.ev1))
    }
}
