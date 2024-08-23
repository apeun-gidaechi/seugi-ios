// bestswlkh0310

import SwiftUI
import Component

public struct JoinWorkspaceSuccessView: View {
    
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var viewModel: JoinWorkspaceViewModel
    @EnvironmentObject private var appState: AppState
    
    public init() {}
    
    public var body: some View {
        VStack(spacing: 16) {
            Spacer()
            VStack(spacing: 0) {
                if case .success(let workspace) = viewModel.workspace {
                    SeugiRoundedCircleAsyncImage.medium(url: workspace.workspaceImageUrl)
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
                router.navigate(to: MainDestination.joinWorkspaceRole)
            }
            .padding(.bottom, 16)
        }
        .padding(.horizontal, 20)
        .seugiTopBar("학교 가입")
    }
}
