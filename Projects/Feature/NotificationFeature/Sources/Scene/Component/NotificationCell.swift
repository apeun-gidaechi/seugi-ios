import SwiftUI
import Component
import Domain
import DateUtil

struct NotificationCell: View {
    
    private let notice: Notice
    
    init(notice: Notice) {
        self.notice = notice
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("\(notice.userName) · \(notice.creationDate?.localeMMDDEEEE ?? "")")
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
                Text(notice.title)
                    .multilineTextAlignment(.leading)
                    .seugiColor(.sub(.black))
                    .font(.subtitle(.s2))
                Text(notice.content)
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
