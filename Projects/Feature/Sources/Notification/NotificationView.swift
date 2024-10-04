import SwiftUI
import Component
import Domain

public struct NotificationView: View {
    @EnvironmentObject private var appState: AppViewModel
    @EnvironmentObject private var router: RouterViewModel
    @StateObject private var viewModel = NotificationViewModel()
    @Component.Alert private var alert
    
    @State private var addEmojiPresent: Bool = false
    
    private var profile: RetrieveProfile? {
        appState.profile.data
    }
}

extension NotificationView {
    
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
            .padding(.horizontal, 20)
        }
        .refreshable {
            guard let selectedWorkspace = appState.selectedWorkspace else {
                return
            }
            viewModel.fetchNotifications(workspaceId: selectedWorkspace.workspaceId)
        }
        .seugiBackground(.primary(.p050))
        .seugiTopBar("공지", background: .seugi(.primary(.p050)))
        .hideBackButton()
        .if(appState.workspaceRole != .student) {
            $0.button(.writeLine) {
                router.navigate(to: MainDestination.createNotification)
            }
        }
        .onReceive(viewModel.$removeNotificationFlow) { flow in
            switch flow {
            case .success:
                alert.present("삭제 성공")
                    .primaryButton("닫기") {}
                    .show()
            case .failure:
                alert.present("삭제 실패")
                    .primaryButton("확인") {}
                    .show()
            default:
                break
            }
        }
        .emojiPicker($addEmojiPresent) { emoji in
            viewModel.patchEmoji(emoji: emoji, profileId: profile?.member.id ?? 0)
        }
        .onReceive(appState.$selectedWorkspace) {
            guard let id = $0?.workspaceId else { return }
            viewModel.fetchNotifications(workspaceId: id)
        }
    }
}

extension NotificationView {
    func handleNotificationAction(
        for notification: Domain.Notification,
        action: NotificationCell.Action
    ) {
        guard let selectedWorkspace = appState.selectedWorkspace else {
            return
        }
        switch action {
        case .updateNotification:
            router.navigate(to: MainDestination.updateNotification(notification))
        case .removeNotification:
            alert.present("공지를 정말 삭제하시겠습니까?")
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
            // TODO: Impl
            break
        case .addEmoji:
            addEmojiPresent = true
            viewModel.selectedNotificationForAddEmoji = notification
        case .emojiClicked(let emoji):
            viewModel.selectedNotificationForAddEmoji = notification
            viewModel.patchEmoji(emoji: emoji, profileId: profile?.member.id ?? 0)
        }
    }
}
