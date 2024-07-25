import SwiftUI
import Component
import BaseFeatureInterface

public struct CreateWorkspaceView: View {
    
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var alertProvider: AlertProvider
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
            SeugiTextFieldForm("학교 이름을 입력해 주세요", text: $viewModel.workspaceName, label: "학교 이름")

            Spacer()
            SeugiButton.large("계속하기", type: .primary, isLoading: viewModel.createWorkspaceFlow == .fetching) {
                viewModel.createWorkspace()
            }
            .padding(.bottom, 16)
        }
        .padding(.horizontal, 20)
        .seugiTopBar("새 학교 등록")
        .onChange(of: viewModel.createWorkspaceFlow) { _ in
            alertProvider.present("학교 등록 성공")
                .show()
            appState.fetchWorkspaces()
        } failure: { _ in
            alertProvider.present("학교 등록 실패")
                .primaryButton("확인") {}
                .message("잠시 후 다시 시도해 주세요")
                .show()
        }
    }
}
