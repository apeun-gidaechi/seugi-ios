import SwiftUI
import Component

public struct PostNotificationView: View {
    
    @EnvironmentObject private var alertProvider: AlertProvider
    @Router private var router
    @AppState private var appState
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = PostNotificationViewModel()
    
    private let type: PostNotificationType
    
    init(
        type: PostNotificationType
    ) {
        self.type = type
        if case .updateNotification(let notification) = type {
            viewModel.title = notification.title
            viewModel.content = notification.content
        }
    }
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                SeugiTextField("제목을 입력해 주세요", text: $viewModel.title)
                SeugiTextField("내용을 입력해 주세요", text: $viewModel.content)
            }
            .padding(.horizontal, 20)
            .padding(.top, 6)
        }
        .scrollIndicators(.hidden)
        .seugiTopBar(type == .createNotification ? "새 공지 작성" : "공지 수정")
        .subView {
            SeugiButton.small("완료", type: .transparent, isLoading: viewModel.fetchPostNotification == .fetching) {
                hideKeyboard() // UX
                switch type {
                case .createNotification:
                    guard let selectedWorkspace = appState.selectedWorkspace else {
                        return
                    }
                    viewModel.createNotification(workspaceId: selectedWorkspace.workspaceId)
                case .updateNotification(let notification):
                    viewModel.updateNotification(notificationId: notification.id)
                }
            }
            .disabled(viewModel.content.isEmpty || viewModel.title.isEmpty)
        }
        .onChange(of: viewModel.fetchPostNotification) { _ in
            alertProvider.present(type == .createNotification ? "공지 작성 성공" : "공지 수정 성공")
                .primaryButton("닫기") {
                    dismiss()
//                    guard let selectedWorkspace = appState.selectedWorkspace else {
//                        return
//                    }
//                    notificationViewModel.fetchNotifications(workspaceId: selectedWorkspace.workspaceId)
                }
                .show()
        } failure: { _ in
            alertProvider.present(type == .createNotification ? "공지 작성 실패" : "공지 수정 실패")
                .message("잠시 후 다시 시도해 주세요")
                .primaryButton("확인") {
                    router.popToStack()
                }
                .show()
        }
    }
}
