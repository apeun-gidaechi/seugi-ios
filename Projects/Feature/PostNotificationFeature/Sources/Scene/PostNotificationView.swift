import SwiftUI
import BaseFeatureInterface
import PostNotificationFeatureInterface
import Component

public struct PostNotificationView: View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var appState: AppState
    @ObservedObject private var viewModel = PostNotificationViewModel()
    
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
                SeugiTextField(text: $viewModel.title)
                SeugiTextField(text: $viewModel.content)
            }
            .padding(.horizontal, 20)
            .padding(.top, 6)
        }
        .scrollIndicators(.hidden)
        .seugiTopBar(type == .createNotification ? "새 공지 작성" : "알림 수정")
        .subView {
            SeugiButton.small("완료", type: .transparent, isLoading: viewModel.fetchPostNotification == .fetching) {
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
        .alertWithAnyView(type == .createNotification ? "공지 작성 성공" : "공지 수정 성공", when: successDialog(for: $viewModel.fetchPostNotification)) {
            Button("닫기") {
                dismiss()
            }
        }
        .alertWithAnyView(type == .createNotification ? "공지 작성 실패" : "공지 수정 실패", when: failureDialog(for: $viewModel.fetchPostNotification)) {
            Button("확인") {
                router.popToStack()
            }
        } message: {
            Text("잠시 후 다시 시도해 주세요")
        }
    }
}
