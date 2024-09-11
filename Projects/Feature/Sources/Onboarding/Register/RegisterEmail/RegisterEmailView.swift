import SwiftUI
import Component
import SwiftUIUtil

public struct RegisterEmailView: View {
    
    @EnvironmentObject private var viewModel: RegisterEmailViewModel
    @Router private var router
    @FocusState private var firstTextField: Bool
    
    public init() {}
    
    public var body: some View {
        VStack(spacing: 16) {
            SeugiTextFieldForm("이름을 입력해 주세요", text: $viewModel.name, label: "이름")
                .padding(.top, 16)
                .focused($firstTextField)
            SeugiTextFieldForm("이메일 입력해 주세요", text: $viewModel.email, label: "이메일")
                .keyboardType(.emailAddress)
            SeugiTextFieldForm("비밀번호 입력해 주세요", text: $viewModel.password, type: .password, label: "비밀번호")
            SeugiTextFieldForm("비밀번호를 다시 입력해 주세요", text: $viewModel.passwordCheck, type: .password, label: "비밀번호 확인")
            Spacer()
            Text("이미 계정이 있으신가요?")
                .seugiColor(.primary(.p500))
                .font(.body(.b1))
                .button {
                    router.navigate(to: OnboardingDestination.emailSignIn)
                }
                .applyAnimation()
            SeugiButton.large("계속하기", type: .primary) {
                router.navigate(to: OnboardingDestination.emailVerification)
            }
            .disabled(viewModel.isInValidInput)
            .padding(.bottom, 16)
        }
        .padding(.horizontal, 20)
        .seugiTopBar("회원가입")
        .hideKeyboardWhenTap()
        .onAppear {
            firstTextField = true
        }
    }
}
