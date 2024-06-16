import SwiftUI
import Component
import BaseFeatureInterface

public struct EmailSignInView: View {
    
    @StateObject private var viewModel: EmailSignInViewModel
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var appState: AppState
    
    public init(vm: EmailSignInViewModel) {
        self._viewModel = StateObject(wrappedValue: vm)
    }
    
    public var body: some View {
        VStack(spacing: 16) {
            SeugiTextFieldForm("이메일을 입력해주세요", text: $viewModel.email, label: "이메일", isForcedLabel: true)
                .keyboardType(.emailAddress)
                .padding(.top, 16)
            SeugiTextFieldForm("비밀번호를 입력해주세요", text: $viewModel.password, type: .password, label: "비밀번호", isForcedLabel: true)
            Spacer()
            HStack(spacing: 4) {
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
                viewModel.signIn()
            }
            .disabled(viewModel.email.isEmpty || viewModel.password.isEmpty)
            .padding(.bottom, 16)
        }
        .padding(.horizontal, 20)
        .seugiTopBar("로그인")
        .alertWithAnyView("로그인 실패", when: $viewModel.showSignInFailureDialog) {
            Button("닫기", role: .cancel) {}
        } message: {
            Text("아이디 혹은 비밀번호를 다시 확인해 주세요")
        }
        .onAppear {
            viewModel.subscribe { subject in
                switch subject {
                case .signInSuccess(let token):
                    let accessToken = String(token.accessToken.split(separator: " ")[1])
                    let refreshToken = String(token.refreshToken.split(separator: " ")[1])
                    print(accessToken, refreshToken)
                    appState.accessToken = accessToken
                    appState.refreshToken = refreshToken
                    appState.fetchWorkspaces()
                    router.navigateToRoot()
                }
            }
        }
    }
}
