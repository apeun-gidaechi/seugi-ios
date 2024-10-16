// bestswlkh0310

import SwiftUI
import Component

struct JoinWorkspaceSuccessView {
    @EnvironmentObject private var alertProvider: AlertProvider
    @EnvironmentObject private var router: RouterViewModel
    @EnvironmentObject private var viewModel: JoinWorkspaceViewModel
}

extension JoinWorkspaceSuccessView: View {
    public var body: some View {
        VStack(spacing: 16) {
            Spacer()
            VStack(spacing: 0) {
                if case .success(let workspace) = viewModel.workspace {
                    SeugiRoundedCircleAsyncImage.medium(
                        url: workspace.workspaceImageUrl
                    )
                    .padding(.bottom, 16)
                    Text(workspace.workspaceName)
                        .font(.subtitle(.s1))
                        .seugiColor(.sub(.black))
                    Text("학생 \(workspace.studentCount)명 선생님 \(workspace.teacherCount)명")
                        .font(.body(.b1))
                        .seugiColor(.gray(.g600))
                }
            }
            Spacer()
            SeugiButton.large("계속하기", type: .primary) {
                viewModel.joinWorkspace()
            }
            .padding(.bottom, 16)
        }
        .padding(.horizontal, 20)
        .seugiTopBar(title: "학교 가입")
        .onReceive(viewModel.$joinFlow) {
            switch $0 {
            case .success:
                router.navigate(to: MainDestination.joinWorkspaceFinish)
            case .failure:
                alertProvider.present(
                    .init(title: "가입 요청 실패")
                    .message("잠시 후 다시 시도해 주세요")
                )
            default:
                break
            }
        }
    }
}
