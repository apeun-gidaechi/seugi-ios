import SwiftUI
import Component

struct NotificationCell: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("박유현 · 5월 3일 수요일")
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
                Text("교내 체육대회 안내")
                    .multilineTextAlignment(.leading)
                    .seugiColor(.sub(.black))
                    .font(.subtitle(.s2))
                Text("5월말 체육대회 합니다. 깔쌈하게 준비해오십시오")
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

#Preview {
    NotificationCell()
}
