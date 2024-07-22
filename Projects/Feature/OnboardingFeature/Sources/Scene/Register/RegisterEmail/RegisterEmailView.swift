import SwiftUI
import Component
import OnboardingFeatureInterface
import BaseFeatureInterface

public struct RegisterEmailView: View {
    
    @StateObject private var viewModel = RegisterEmailViewModel()
    @EnvironmentObject private var router: Router
    
    public init() {}
    
    public var body: some View {
        VStack(spacing: 16) {
            SeugiTextFieldForm("이름을 입력해 주세요", text: $viewModel.name, label: "이름")
                .padding(.top, 16)
            SeugiTextFieldForm("이메일 입력해 주세요", text: $viewModel.email, label: "이메일")
                .keyboardType(.emailAddress)
            SeugiTextFieldForm("비밀번호 입력해 주세요", text: $viewModel.password, type: .password, label: "비밀번호")
            SeugiTextFieldForm("비밀번호를 다시 입력해 주세요", text: $viewModel.passwordCheck, type: .password, label: "비밀번호 확인")
            Spacer()
            Button {
                router.navigate(to: OnboardingDestination.emailSignIn)
            } label: {
                Text("이미 계정이 있으신가요?")
                    .seugiColor(.primary(.p500))
                    .font(.body(.b1))
            }
            SeugiButton.large("계속하기", type: .primary) {
                router.navigate(to: OnboardingDestination.emailVerification(name: viewModel.name, email: viewModel.email, password: viewModel.password))
            }
            .disabled(viewModel.isInValidInput)
            .padding(.bottom, 16)
        }
        .padding(.horizontal, 20)
        .seugiTopBar("회원가입")
        .hideKeyboardWhenTap()
    }
}