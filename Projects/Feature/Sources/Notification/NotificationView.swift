import SwiftUI
import Component
import Domain

public struct NotificationView: View {
    
    @AppState private var appState
    @Router private var router
    @EnvironmentObject private var viewModel: NotificationViewModel
    @EnvironmentObject private var alertProvider: AlertProvider
    
    @State private var addEmojiPresent = false
    
    private var profile: RetrieveProfile? {
        appState.profile.data
    }
    
    func handleNotificationAction(for notification: Domain.Notification, action: NotificationCell.Action) {
        switch action {
        case .updateNotification: router.navigate(to: MainDestination.updateNotification(notification))
        case .removeNotification:
            guard let selectedWorkspace = appState.selectedWorkspace else {
                return
            }
            alertProvider.present("공지를 정말 삭제하시겠습니까?")
                .primaryButton("삭제") {
                    viewModel.removeNotification(
                        workspaceId: selectedWorkspace.workspaceId,
                        notificationId: notification.id
                    )
                    viewModel.fetchNotifications(
                        workspaceId: selectedWorkspace.workspaceId
                    )
                }
                .secondaryButton("닫기") {}
                .show()
        case .reportNotification:
            break
        case .addEmoji:
            addEmojiPresent = true
            viewModel.selectedNotificationForAddEmoji = notification
        case .emojiClicked(let emoji):
            guard let selectedWorkspace = appState.selectedWorkspace else {
                return
            }
            viewModel.patchEmoji(emoji: emoji, workspaceId: selectedWorkspace.workspaceId)
            viewModel.selectedNotificationForAddEmoji = notification
        }
    }
    
    public var body: some View {
        ScrollView {
            viewModel.notifications.makeView {
                ProgressView()
            } success: { notifications in
                LazyVStack(spacing: 8) {
                    if notifications.isEmpty {
                        SeugiError("공지가 없어요", image: .faceWithDiagonalMouth)
                    } else {
                        Spacer().frame(height: 12)
                        ForEach(notifications, id: \.id) { notification in
                            NotificationCell(
                                profileId: profile?.member.id ?? 0,
                                notification: notification
                            ) {
                                handleNotificationAction(for: notification, action: $0)
                            }
                        }
                        Spacer().frame(height: 80)
                    }
                }
            } failure: { _ in
                SeugiError("불러오기 실패", image: .faceWithDiagonalMouth)
            }
        }
        .refreshable {
            guard let selectedWorkspace = appState.selectedWorkspace else {
                return
            }
            viewModel.fetchNotifications(workspaceId: selectedWorkspace.workspaceId)
        }
        .padding(.horizontal, 20)
        .seugiBackground(.primary(.p050))
        .seugiTopBar("공지", background: .seugi(.primary(.p050)))
        .hideBackButton()
        .if(appState.workspaceRole != .student) {
            $0.button(.writeLine) {
                router.navigate(to: MainDestination.createNotification)
            }
        }
        .onChange(of: viewModel.removeNotificationFlow) { _ in
            alertProvider.present("삭제 성공")
                .primaryButton("닫기") {}
                .show()
        } failure: { _ in
            alertProvider.present("삭제 실패")
                .primaryButton("확인") {}
                .show()
        }
        .emojiPicker($addEmojiPresent) { emoji in
            guard let selectedWorkspace = appState.selectedWorkspace else {
                return
            }
            viewModel.patchEmoji(emoji: emoji, workspaceId: selectedWorkspace.workspaceId)
        }
    }
}
