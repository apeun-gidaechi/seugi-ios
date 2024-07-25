import SwiftUI
import Component
import BaseFeatureInterface
import JoinWorkspaceFeatureInterface

public struct JoinWorkspaceCodeView: View {
    
    @EnvironmentObject private var viewModel: JoinWorkspaceViewModel
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var alertProvider: AlertProvider
    
    public init() {}
    
    public var body: some View {
        VStack(spacing: 16) {
            SeugiCodeTextFieldForm(text: $viewModel.code, label: "초대코드", length: 6)
                .padding(.top, 16)
            Spacer()
            SeugiButton.large("계속하기", type: .primary, isLoading: viewModel.workspace == .fetching) {
                viewModel.fetchWorkspace()
            }
            .disabled(viewModel.isInValidInput)
            .padding(.bottom, 16)
        }
        .padding(.horizontal, 20)
        .seugiTopBar("학교 가입")
        .onChange(of: viewModel.workspace) { _ in } failure: { _ in
            alertProvider.present("초대코드가 올바르지 않습니다")
                .message("다시 입력해주세요")
                .show()
        }
        .onAppear {
            viewModel.subscribe { subject in
                switch subject {
                case .fetchWorkspaceSuccess: router.navigate(to: JoinWorkspaceDestination.joinSuccess)
                default:
                    break
                }
            }
        }
    }
}
