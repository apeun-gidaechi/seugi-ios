import SwiftUI
import Component
import Domain
import SwiftUIUtil
import SwiftUtil

struct LoginEmailView {
    enum FocusedField {
        case email, password
    }
    
    @EnvironmentObject private var alertProvider: AlertProvider
    @StateObject private var viewModel = LoginEmailViewModel()
    @EnvironmentObject private var router: RouterViewModel
    @EnvironmentObject private var appState: AppViewModel
    @FocusState private var focused: FocusedField?
}

extension LoginEmailView: View {
    public var body: some View {
        VStack(spacing: 16) {
            SeugiTextFieldForm("이메일을 입력해주세요", text: $viewModel.email, label: "이메일", isForcedLabel: true)
                .keyboardType(.emailAddress)
                .padding(.top, 16)
                .focused($focused, equals: .email)
                .onSubmit {
                    focused = .password
                }
            SeugiTextFieldForm(
                "비밀번호를 입력해주세요",
                text: $viewModel.password,
                type: .password,
                label: "비밀번호",
                isForcedLabel: true
            )
            .focused($focused, equals: .password)
            Spacer()
            HStack(spacing: 4) {
                Text("계정이 없으시다면?")
                    .font(.body(.b1))
                    .seugiColor(.gray(.g600))
                Button {
                    router.navigate(to: OnboardingDestination.emailSignUp)
                } label: {
                    Text("가입하기")
                        .font(.body(.b1))
                        .seugiColor(.primary(.p500))
                }
                .scaledButtonStyle()
            }
            SeugiButton.large(
                "로그인",
                type: .primary,
                isLoading: viewModel.signInFlow.is(.fetching)
            ) {
                viewModel.signIn()
            }
            .disabled(viewModel.email.isEmpty || viewModel.password.isEmpty)
            .padding(.bottom, 16)
        }
        .padding(.horizontal, 20)
        .seugiTopBar(title: "로그인")
        .onAppear {
            focused = .email
        }
        .onReceive(viewModel.$signInFlow) { flow in
            switch flow {
            case .success(let token):
                Log.info("EmailSignInView - 로그인 성공")
                withAnimation {
                    appState.setToken(
                        accessToken: String(token.accessToken.split(separator: " ")[1]),
                        refreshToken: String(token.refreshToken.split(separator: " ")[1])
                    )
                    router.navigateToRoot()
                }
            case .failure:
                alertProvider.present(
                    .init(title: "로그인 실패")
                    .message("아이디 혹은 비밀번호를 다시 확인해 주세요")
                )
            default:
                break
            }
        }
    }
}
