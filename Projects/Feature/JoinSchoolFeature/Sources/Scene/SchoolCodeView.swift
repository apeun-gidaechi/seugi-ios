import SwiftUI
import Component
import BaseFeatureInterface

public struct SchoolCodeView: View {
    
    @EnvironmentObject private var viewModel: JoinSchoolViewModel
    @EnvironmentObject private var router: Router
    
    public init() {}
    
    public var body: some View {
        VStack(spacing: 16) {
            SeugiCodeTextFieldForm(text: $viewModel.code, label: "초대코드", length: 6)
                .padding(.top, 16)
            Spacer()
            SeugiButton.large("계속하기", type: .primary, isLoading: viewModel.isFetchWorkspace) {
                viewModel.fetchWorkspace()
            }
            .disabled(viewModel.isInValidInput)
            .padding(.bottom, 16)
        }
        .padding(.horizontal, 20)
        .seugiTopBar("학교 가입")
        .alert("초대코드가 올바르지 않습니다", isPresented: $viewModel.isFetchFailure) {
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
