import SwiftUI
import BaseFeatureInterface
import Component

public struct EmailVerificationView: View {
    
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var timerManager: TimerManager
    @EnvironmentObject private var appState: AppState
    @StateObject private var viewModel: EmailVerificationViewModel
    
    private let name: String
    private let email: String
    private let password: String
    
    public init(
        viewModel: EmailVerificationViewModel,
        name: String,
        email: String,
        password: String
    ) {
        viewModel.name = name
        viewModel.email = email
        viewModel.password = password
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.name = name
        self.email = email
        self.password = password
    }
    
    public var body: some View {
        VStack(spacing: 8) {
            SeugiCodeTextFieldForm(text: $viewModel.verificationCode, label: "인증코드", length: 6)
                .keyboardType(.numberPad)
                .padding(.top, 16)
            emailSend()
                .toTrailing()
            Spacer()
            SeugiButton.large("계속하기", type: .primary, isLoading: viewModel.isFetchSignUp) {
                viewModel.signUp()
            }
            .disabled(viewModel.isInValidInput)
            .padding(.bottom, 16)
        }
        .padding(.horizontal, 20)
        .seugiTopBar("이메일 인증")
        .alertWithAnyView("회원가입 실패", when: failureDialog(for: $viewModel.signUpFlow)) {
            Button("닫기", role: .cancel) {}
        } message: {
            if let text = viewModel.signUpFlow.httpError?.message {
                Text(text)
            } else {
                Text("잠시 후 다시 시도해 주세요")
            }
        }
        .alertWithAnyView("이메일 전송 실패", when: failureDialog(for: $viewModel.sendEmailFlow)) {
            Button("닫기", role: .cancel) {}
        }
        .onChangeIdleFlow(of: viewModel.signUpFlow) {
            router.navigateToRoot()
        }
        .onAppear {
            viewModel.subscribe { subject in
                switch subject {
                case .registerSuccess(let token):
                    appState.accessToken = String(token.accessToken.split(separator: " ")[1])
                    appState.refreshToken = String(token.refreshToken.split(separator: " ")[1])
                }
            }
        }
    }
    
    func convertSecondsToTime(timeInSeconds: Int) -> String {
        let minutes = timeInSeconds / 60
        let seconds = timeInSeconds % 60
        return String(format: "%02i분 %02i초 남음", minutes, seconds)
    }
    
    @ViewBuilder
    private func emailSend() -> some View {
        if viewModel.isWaiting {
            Text(convertSecondsToTime(timeInSeconds: timerManager.timeRemaining))
                .font(.body(.b2))
                .seugiColor(.gray(.g600))
        } else {
            SeugiButton.small("인증 코드 전송", type: .primary) {
                timerManager.startTimer {
                    viewModel.isWaiting = false
                }
                viewModel.sendEmail()
            }
        }
    }
}
