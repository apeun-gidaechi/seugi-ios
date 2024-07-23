import SwiftUI
import Component
import Domain
import DateUtil

struct NotificationCell: View {
    
    private let notification: Domain.Notification
    
    init(notification: Domain.Notification) {
        self.notification = notification
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("\(notification.userName) · \(notification.creationDate?.localeMMDDEEEE ?? "")")
                    .seugiColor(.gray(.g600))
                    .font(.body(.b2))
                Spacer()
                Image(icon: .detailVerticalLine)
                    .resizable()
                    .renderingMode(.template)
                    .seugiColor(.gray(.g500))
                    .frame(width: 24, height: 24)
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
            HStack(spacing: 10) {
                Image(icon: .addEmoji)
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 28, height: 28)
                    .seugiColor(.gray(.g600))
                    .padding(4)
                Spacer()
            }
        }
        .padding(12)
        .seugiBackground(.sub(.white))
        .cornerRadius(8)
        .shadow(.evBlack(.ev1))
    }
}
