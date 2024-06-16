// bestswlkh0310

import SwiftUI
import Component
import BaseFeatureInterface
import JoinSuccessFeatureInterface

public struct JoinSuccessView: View {
    
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var joinWorkspaceManager: JoinWorkspaceManager
    @EnvironmentObject private var appState: AppState
    
    public init() {}
    
    public var body: some View {
        VStack(spacing: 16) {
            Spacer()
            VStack(spacing: 0) {
//                if case .success(let workspace) = joinWorkspaceManager.workspace {
//                    SeugiRoundedCircleAsyncImage.small(url: workspace.workspaceImageUrl)
//                        .padding(.bottom, 16)
//                    Text(workspace.workspaceName)
//                        .font(.subtitle(.s1))
//                        .seugiColor(.sub(.black))
//                    Text("학생 \(workspace.studentCount)명 선생님 \(workspace.teacherCount)명")
//                        .font(.body(.b1))
//                        .seugiColor(.gray(.g600))
//                }
            }
            Spacer()
            SeugiButton.large("계속하기", type: .primary) {
                joinWorkspaceManager.joinWorkspace()
            }
            .padding(.bottom, 16)
        }
        .padding(.horizontal, 20)
        .seugiTopBar("학교 가입")
        .alertWithAnyView("가입 요청 성공", when: successDialog(for: $joinWorkspaceManager.joinFlow)) {
            Button("닫기", role: .cancel) {}
        } message: {
            Text("요청 수락을 기다려 주세요")
        }
        .alertWithAnyView("가입 요청 실패", when: failureDialog(for: $joinWorkspaceManager.joinFlow)) {
            Button("닫기", role: .cancel) {}
        } message: {
            Text("잠시 후 다시 시도해 주세요")
        }
    }
}
