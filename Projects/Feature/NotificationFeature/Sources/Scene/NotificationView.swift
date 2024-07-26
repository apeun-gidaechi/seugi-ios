import SwiftUI
import Component
import NotificationFeatureInterface
import BaseFeatureInterface

public struct NotificationView: View {
    
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var notificationViewModel: NotificationViewModel
    @EnvironmentObject private var router: Router
    
    public var body: some View {
        ScrollView {
            notificationViewModel.notifications.makeView {
                ProgressView()
            } success: { notifications in
                LazyVStack(spacing: 8) {
                    if notifications.isEmpty {
                        SeugiError("알림이 없어요", image: .faceWithDiagonalMouth)
                    } else {
                        Spacer()
                            .frame(height: 12)
                        ForEach(notifications, id: \.id) { notification in
                            NotificationCell(notification: notification) {
                                switch $0 {
                                case .updateNotification: router.navigate(to: NotificationDestination.updateNotification(notification))
                                }
                            }
                            .button {
                                // TODO: navigate to notification detail
                            }
                            .applyAnimation()
                        }
                        Spacer()
                            .frame(height: 80)
                    }
                }
            } failure: { _ in
                SeugiError("불러오기 실패", image: .faceWithDiagonalMouth)
            }
        }
        .scrollIndicators(.hidden)
        .refreshable {
            guard let selectedWorkspace = appState.selectedWorkspace else {
                return
            }
            notificationViewModel.fetchNotifications(workspaceId: selectedWorkspace.workspaceId)
        }
        .padding(.horizontal, 20)
        .seugiBackground(.primary(.p050))
        .seugiTopBar("알림", background: .seugi(.primary(.p050)))
        .hideBackButton()
        .if(appState.workspaceRole != .teacher) {
            $0.button(.writeLine) {
                router.navigate(to: NotificationDestination.createNotification)
            }
        }
    }
}
