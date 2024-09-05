import SwiftUI
import Component
import Domain

public struct NotificationView: View {
    
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var viewModel: NotificationViewModel
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var alertProvider: AlertProvider
    
    private var profile: RetrieveProfile? {
        appState.profile.data
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
                        Spacer()
                            .frame(height: 12)
                        ForEach(notifications, id: \.id) { notification in
                            NotificationCell(
                                profileId: profile?.member.id ?? 0,
                                notification: notification
                            ) {
                                switch $0 {
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
                                }
                            }
//                            .button {
//                                // TODO: navigate to notification detail
//                            }
//                            .applyAnimation()
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
    }
}
