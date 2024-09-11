import SwiftUI
import Component

public struct RegisterEmailVerificationView: View {
    
    @EnvironmentObject private var alertProvider: AlertProvider
    @Router private var router
    @EnvironmentObject private var timerManager: TimerManager
    @AppState private var appState
    @EnvironmentObject private var viewModel: RegisterEmailViewModel
    @FocusState private var firstTextField: Bool
    
    public init() {}
    
    public var body: some View {
        VStack(spacing: 8) {
            SeugiCodeTextFieldForm(text: $viewModel.verificationCode, label: "인증코드", length: 6)
                .keyboardType(.numberPad)
                .padding(.top, 16)
                .focused($firstTextField)
            emailSend()
                .toTrailing()
            Spacer()
            SeugiButton.large("계속하기", type: .primary, isLoading: viewModel.signUpFlow == .fetching) {
                viewModel.signUp()
            }
            .disabled(viewModel.isInValidCodeInput)
            .padding(.bottom, 16)
        }
        .padding(.horizontal, 20)
        .seugiTopBar("이메일 인증")
        .onChange(of: viewModel.signUpFlow) { _ in
            router.navigateToRoot()
        } failure: { _ in
            let message = viewModel.signUpFlow.httpError?.message ?? "잠시 후 다시 시도해 주세요"
            alertProvider.present("회원가입 실패")
                .message(message)
                .show()
        }
        .onChangeFailure(of: viewModel.sendEmailFlow) { _ in
            alertProvider.present("이메일 전송 실패")
                .show()
        }
        .onAppear {
            viewModel.subscribe { subject in
                switch subject {
                case .registerSuccess(let token):
                    appState.accessToken = String(token.accessToken.split(separator: " ")[1])
                    appState.refreshToken = String(token.refreshToken.split(separator: " ")[1])
                }
            }
            firstTextField = true
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
