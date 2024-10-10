import SwiftUI
import Component
import SwiftUIUtil

public struct RegisterEmailView {
    @EnvironmentObject private var viewModel: RegisterEmailViewModel
    @EnvironmentObject private var router: RouterViewModel
    
    @FocusState private var firstTextField: Bool
    
    public init() {}
}

extension RegisterEmailView: View {
    public var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                SeugiTextFieldForm(
                    "이름을 입력해 주세요",
                    text: $viewModel.name,
                    label: "이름"
                )
                .padding(.top, 16)
                .focused($firstTextField)
                SeugiTextFieldForm(
                    "이메일 입력해 주세요",
                    text: $viewModel.email,
                    label: "이메일"
                )
                .keyboardType(.emailAddress)
                SeugiTextFieldForm(
                    "비밀번호 입력해 주세요",
                    text: $viewModel.password,
                    type: .password,
                    label: "비밀번호"
                )
                SeugiTextFieldForm(
                    "비밀번호를 다시 입력해 주세요",
                    text: $viewModel.passwordCheck,
                    type: .password,
                    label: "비밀번호 확인"
                )
                Spacer()
            }
            .padding(.horizontal, 20)
        }
        .scrollIndicators(.hidden)
        .seugiTopBar(title: "회원가입")
        .safeAreaInset(edge: .bottom) {
            VStack(spacing: 16) {
                Button {
                    router.navigate(to: OnboardingDestination.emailSignIn)
                } label: {
                    Text("이미 계정이 있으신가요?")
                        .seugiColor(.primary(.p500))
                        .font(.body(.b1))
                }
                .scaledButtonStyle()
                SeugiButton.large("계속하기", type: .primary) {
                    router.navigate(to: OnboardingDestination.emailVerification)
                }
                .disabled(viewModel.isInValidInput)
                .padding(.bottom, 16)
            }
            .padding(.horizontal, 20)
            .safeAreaBottomGradientMask()
        }
        .hideKeyboardWhenTap()
        .onAppear {
            firstTextField = true
        }
    }
}
