import SwiftUI
import Component

public struct NotificationView: View {
    public var body: some View {
        ScrollView {
            LazyVStack(spacing: 8) {
                Spacer()
                    .frame(height: 12)
                ForEach(0..<10, id: \.self) { _ in
                    NotificationCell()
                }
                Spacer()
                    .frame(height: 80)
            }
        }
        .scrollIndicators(.hidden)
        .padding(.horizontal, 20)
        .seugiBackground(.primary(.p050))
        .seugiTopBar("알림", background: .seugi(.primary(.p050)))
        .hideBackButton()
    }
}
