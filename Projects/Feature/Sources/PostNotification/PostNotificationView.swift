import SwiftUI
import Component

public struct PostNotificationView {
    enum FocusedField {
        case title, content
    }
    
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject private var alertProvider: AlertProvider
    @EnvironmentObject private var router: RouterViewModel
    @EnvironmentObject private var appState: AppViewModel
    @EnvironmentObject private var notificationViewModel: NotificationViewModel
    
    @StateObject private var viewModel = PostNotificationViewModel()
    
    @FocusState private var focused: FocusedField?
    
    private let type: PostNotificationType
    
    init(type: PostNotificationType) {
        self.type = type
        if case .updateNotification(let notification) = type {
            viewModel.title = notification.title
            viewModel.content = notification.content
        }
    }
}

extension PostNotificationView: View {
    public var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                SeugiTextField("제목을 입력해 주세요", text: $viewModel.title)
                    .focused($focused, equals: .title)
                    .onSubmit {
                        self.focused = .content
                    }
                SeugiTextEditor(text: $viewModel.content)
                    .focused($focused, equals: .content)
                    .onSubmit {
                        self.focused = nil
                    }
            }
            .padding(.horizontal, 20)
            .padding(.top, 6)
        }
        .scrollIndicators(.hidden)
        .seugiTopBar(
            title: type == .createNotification ? "새 공지 작성" : "공지 수정",
            subView: {
                SeugiButton.small("완료", type: .transparent, isLoading: viewModel.fetchPostNotification == .fetching) {
                    hideKeyboard() // for UX
                    if let workspaceId = appState.selectedWorkspace?.workspaceId {
                        notificationViewModel.fetchNotifications(workspaceId: workspaceId)
                    }
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
                .disabled(!viewModel.isValidInput)
            }
        )
        .onAppear {
            self.focused = .title
        }
        .onReceive(viewModel.$fetchPostNotification) { flow in
            switch flow {
            case .success:
                alertProvider.present(
                    .init(title: type == .createNotification ? "공지 작성 성공" : "공지 수정 성공")
                    .primaryButton("닫기") {
                        dismiss()
                    }
                )
            case .failure:
                alertProvider.present(
                    .init(title: type == .createNotification ? "공지 작성 실패" : "공지 수정 실패")
                    .message("잠시 후 다시 시도해 주세요")
                    .primaryButton("확인") {
                        router.popToStack()
                    }
                )
            default:
                break
            }
        }
    }
}
