import SwiftUI
import Component
import NotificationFeatureInterface

public struct NotificationView: View {
    
    @EnvironmentObject private var notificationViewModel: NotificationViewModel
    
    public var body: some View {
        ScrollView {
            LazyVStack(spacing: 8) {
                Spacer()
                    .frame(height: 12)
                notificationViewModel.notices.makeView {
                    ProgressView()
                } success: { notices in
                    ForEach(notices, id: \.id) { notice in
                        NotificationCell(notice: notice)
                    }
                } failure: { _ in
                    Text("-")
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
