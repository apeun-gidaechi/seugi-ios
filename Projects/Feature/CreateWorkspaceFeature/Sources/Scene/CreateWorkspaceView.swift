import SwiftUI
import Component
import BaseFeatureInterface

public struct CreateWorkspaceView: View {
    
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var router: Router
    @ObservedObject private var viewModel = CreateWorkspaceViewModel()
    
    public var body: some View {
        VStack(spacing: 16) {
            ZStack(alignment: .bottomTrailing) {
                SeugiRoundedCircleImage.small(type: .icon(.imageLine))
                Image(icon: .addFill)
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 24, height: 24)
                    .seugiColor(.gray(.g600))
            }
            .button {
                // TODO: Handle to pick image
            }
            .applyAnimation()
            .padding(.top, 16)
            SeugiTextField("학교 이름을 입력해 주세요", text: $viewModel.workspaceName)

            Spacer()
            SeugiButton.large("계속하기", type: .primary, isLoading: viewModel.createWorkspaceFlow == .fetching) {
                viewModel.createWorkspace()
            }
            .padding(.bottom, 16)
        }
        .padding(.horizontal, 20)
        .seugiTopBar("새 학교 등록")
        .alertWithAnyView("학교 등록 성공", when: successDialog(for: $viewModel.createWorkspaceFlow)) {
            Button("닫기") {
                router.popToStack()
            }
        }
        .alertWithAnyView("학교 등록 실패", when: failureDialog(for: $viewModel.createWorkspaceFlow)) {
            Button("확인") {}
        } message: {
            Text("잠시 후 다시 시도해 주세요")
        }
        .onChangeIdleFlow(of: viewModel.createWorkspaceFlow) {
            appState.fetchWorkspaces()
        }
    }
}
