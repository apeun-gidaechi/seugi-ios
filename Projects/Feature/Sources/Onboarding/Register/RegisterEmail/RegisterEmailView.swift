import SwiftUI
import Component
import SwiftUIUtil

struct RegisterEmailView {
    enum FocusedField {
        case name, email, password, passwordCheck
    }
    
    @EnvironmentObject private var viewModel: RegisterEmailViewModel
    @EnvironmentObject private var router: RouterViewModel
    
    @FocusState private var focused: FocusedField?
}

extension RegisterEmailView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                SeugiTextFieldForm(
                    "이름을 입력해 주세요",
                    text: $viewModel.name,
                    label: "이름"
                )
                .padding(.top, 16)
                .focused($focused, equals: .name)
                .onSubmit {
                    focused = .email
                }
                SeugiTextFieldForm(
                    "이메일 입력해 주세요",
                    text: $viewModel.email,
                    label: "이메일"
                )
                .keyboardType(.emailAddress)
                .focused($focused, equals: .email)
                .onSubmit {
                    focused = .password
                }
                SeugiTextFieldForm(
                    "비밀번호 입력해 주세요",
                    text: $viewModel.password,
                    type: .password,
                    label: "비밀번호"
                )
                .focused($focused, equals: .password)
                .onSubmit {
                    focused = .passwordCheck
                }
                SeugiTextFieldForm(
                    "비밀번호를 다시 입력해 주세요",
                    text: $viewModel.passwordCheck,
                    type: .password,
                    label: "비밀번호 확인"
                )
                .focused($focused, equals: .passwordCheck)
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
            focused = .name
        }
    }
}
