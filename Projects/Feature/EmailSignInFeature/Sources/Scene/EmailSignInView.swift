import SwiftUI
import DesignSystem
import BaseFeatureInterface

public struct EmailSignInView: View {
    
    @ObservedObject private var viewModel: EmailSignInViewModel
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var appState: AppState
    
    public init(vm: EmailSignInViewModel) {
        self.viewModel = vm
    }
    
    public var body: some View {
        VStack(spacing: 16) {
            SeugiTextFieldForm("이메일을 입력해주세요", text: $viewModel.email, label: "이메일", isForcedLabel: true)
                .keyboardType(.emailAddress)
                .padding(.top, 16)
            SeugiTextFieldForm("비밀번호를 입력해주세요", text: $viewModel.password, type: .password, label: "비밀번호", isForcedLabel: true)
            Spacer()
            HStack(spacing: 0) {
                Text("계정이 없으시다면?")
                    .font(.body(.b1))
                    .seugiColor(.gray(.g600))
                Button {
                    router.navigate(to: EmailSignInDesination.emailSignUp)
                } label: {
                    Text("가입하기")
                        .font(.body(.b1))
                        .seugiColor(.primary(.p500))
                }
            }
            SeugiButton.large("로그인", type: .primary, isLoading: viewModel.isSignInFetching) {
                Task {
                    await viewModel.signIn { token in
                        appState.setAccessToken(with: String(token.accessToken.split(separator: " ")[1]))
                        appState.setRefreshToken(with: String(token.refreshToken.split(separator: " ")[1]))
                        await appState.fetchWorkspaces()
                    }
                }
            }
            .disabled(viewModel.email.isEmpty || viewModel.password.isEmpty)
            .padding(.bottom, 16)
        }
        .padding(.horizontal, 20)
        .seugiTopBar("로그인")
    }
}
