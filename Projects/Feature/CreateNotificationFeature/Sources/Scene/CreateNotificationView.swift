import SwiftUI
import BaseFeatureInterface
import Component

public struct CreateNotificationView: View {
    
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var appState: AppState
    @ObservedObject private var viewModel = CreateNotificationViewModel()
    
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
        .seugiTopBar("새 공지 작성")
        .subView {
            SeugiButton.small("완료", type: .transparent, isLoading: viewModel.fetchCreateNotification == .fetching) {
                guard let selectedWorkspace = appState.selectedWorkspace else {
                    return
                }
                viewModel.createNotification(workspaceId: selectedWorkspace.workspaceId)
            }
            .disabled(viewModel.content.isEmpty || viewModel.title.isEmpty)
        }
        .alertWithAnyView("공지 작성 성공", when: successDialog(for: $viewModel.fetchCreateNotification)) {
            Button("닫기") {}
        }
        .alertWithAnyView("공지 작성 실패", when: failureDialog(for: $viewModel.fetchCreateNotification)) {
            Button("확인") {
                router.popToStack()
            }
        }
    }
}
