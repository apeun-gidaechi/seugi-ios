import SwiftUI
import Component
import Domain
import SwiftUIUtil

public struct LoginEmailView: View {
    
    @EnvironmentObject private var alertProvider: AlertProvider
    @StateObject private var viewModel = LoginEmailViewModel()
    @Router private var router
    @AppState private var appState
    @FocusState private var firstTextField: Bool
    
    public init() {}
    
    public var body: some View {
        VStack(spacing: 16) {
            SeugiTextFieldForm("이메일을 입력해주세요", text: $viewModel.email, label: "이메일", isForcedLabel: true)
                .keyboardType(.emailAddress)
                .padding(.top, 16)
                .focused($firstTextField)
            SeugiTextFieldForm("비밀번호를 입력해주세요", text: $viewModel.password, type: .password, label: "비밀번호", isForcedLabel: true)
            Spacer()
            HStack(spacing: 4) {
                Text("계정이 없으시다면?")
                    .font(.body(.b1))
                    .seugiColor(.gray(.g600))
                Text("가입하기")
                    .font(.body(.b1))
                    .seugiColor(.primary(.p500))
                    .button {
                        router.navigate(to: OnboardingDestination.emailSignUp)
                    }
                    .applyAnimation()
            }
            SeugiButton.large("로그인", type: .primary, isLoading: viewModel.signInFlow == .fetching) {
                viewModel.signIn()
            }
            .disabled(viewModel.email.isEmpty || viewModel.password.isEmpty)
            .padding(.bottom, 16)
        }
        .padding(.horizontal, 20)
        .seugiTopBar("로그인")
        .onChange(of: viewModel.signInFlow) { token in
            Log.info("EmailSignInView - 로그인 성공")
            let accessToken = String(token.accessToken.split(separator: " ")[1])
            let refreshToken = String(token.refreshToken.split(separator: " ")[1])
            withAnimation {
                appState.accessToken = accessToken
                appState.refreshToken = refreshToken
                appState.login()
                router.navigateToRoot()
            }
        } failure: { _ in
            alertProvider.present("로그인 실패")
                .message("아이디 혹은 비밀번호를 다시 확인해 주세요")
                .show()
        }
        .onAppear {
            firstTextField = true
        }
    }
}
