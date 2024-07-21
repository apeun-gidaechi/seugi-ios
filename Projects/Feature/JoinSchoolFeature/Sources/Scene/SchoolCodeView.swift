import SwiftUI
import Component
import BaseFeatureInterface

public struct SchoolCodeView: View {
    
    @EnvironmentObject private var joinWorkspaceManager: JoinWorkspaceManager
    @EnvironmentObject private var router: Router
    
    public init() {}
    
    public var body: some View {
        VStack(spacing: 16) {
            SeugiCodeTextFieldForm(text: $joinWorkspaceManager.code, label: "초대코드", length: 6)
                .padding(.top, 16)
            Spacer()
            SeugiButton.large("계속하기", type: .primary, isLoading: joinWorkspaceManager.isFetchWorkspace) {
                joinWorkspaceManager.fetchWorkspace()
            }
            .disabled(joinWorkspaceManager.isInValidInput)
            .padding(.bottom, 16)
        }
        .padding(.horizontal, 20)
        .seugiTopBar("학교 가입")
        .hideBackButton()
        .alert("초대코드가 올바르지 않습니다", isPresented: $joinWorkspaceManager.isFetchFailure) {
            Button("닫기", role: .cancel) {}
        } message: {
            Text("다시 입력해주세요")
        }
//        .onChange(of: joinWorkspaceManager.workspace) {
//            if case .success = $0 {
//                router.navigate(to: SchoolCodeDestination.joinSuccess)
//            }
//        }
    }
}
