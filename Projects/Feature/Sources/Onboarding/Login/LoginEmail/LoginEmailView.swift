import SwiftUI
import Component
import Domain
import SwiftUIUtil
import SwiftUtil

public struct LoginEmailView: View {
    @EnvironmentObject private var alertProvider: AlertProvider
    @StateObject private var viewModel = LoginEmailViewModel()
    @EnvironmentObject private var router: RouterViewModel
    @EnvironmentObject private var appState: AppViewModel
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
                    .scaledButtonStyle()
            }
            SeugiButton.large("로그인", type: .primary, isLoading: viewModel.signInFlow.is(.fetching)) {
                viewModel.signIn()
            }
            .disabled(viewModel.email.isEmpty || viewModel.password.isEmpty)
            .padding(.bottom, 16)
        }
        .padding(.horizontal, 20)
        .seugiTopBar(title: "로그인")
        .onReceive(viewModel.$signInFlow) { flow in
            switch flow {
            case .success(let token):
                Log.info("EmailSignInView - 로그인 성공")
                let accessToken = String(token.accessToken.split(separator: " ")[1])
                let refreshToken = String(token.refreshToken.split(separator: " ")[1])
                withAnimation {
                    appState.accessToken = accessToken
                    appState.refreshToken = refreshToken
                    appState.login()
                    router.navigateToRoot()
                }
            case .failure:
                alertProvider.present("로그인 실패")
                    .message("아이디 혹은 비밀번호를 다시 확인해 주세요")
                    .show()
            default:
                break
            }
        }
        .onAppear {
            firstTextField = true
        }
    }
}
