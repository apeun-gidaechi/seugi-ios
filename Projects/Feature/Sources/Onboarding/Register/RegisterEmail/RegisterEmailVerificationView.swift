import SwiftUI
import Component

public struct RegisterEmailVerificationView: View {
    
    @EnvironmentObject private var alertProvider: AlertProvider
    @EnvironmentObject private var router: RouterViewModel
    @StateObject private var timerManager = TimerManager()
    @EnvironmentObject private var appState: AppViewModel
    @EnvironmentObject private var viewModel: RegisterEmailViewModel
    @FocusState private var firstTextField: Bool
    
    public init() {}
    
    public var body: some View {
        VStack(spacing: 8) {
            SeugiCodeTextFieldForm(text: $viewModel.verificationCode, label: "인증코드", length: 6)
                .keyboardType(.numberPad)
                .padding(.top, 16)
            // TODO: 함수로 분리 ?? 할 수도 있을 듯~
                .focused($firstTextField).onAppear { firstTextField = true }
            emailSend()
                .toTrailing()
            Spacer()
            SeugiButton.large("계속하기", type: .primary, isLoading: viewModel.signUpFlow.is(.fetching)) {
                viewModel.signUp()
            }
            .disabled(viewModel.isInValidCodeInput)
            .padding(.bottom, 16)
        }
        .padding(.horizontal, 20)
        .seugiTopBar(title: "이메일 인증")
        .onReceive(viewModel.$signUpFlow) { flow in
            switch flow {
            case .success(let token):
                appState.accessToken = String(token.accessToken.split(separator: " ")[1])
                appState.refreshToken = String(token.refreshToken.split(separator: " ")[1])
                router.navigateToRoot()
            case .failure:
//                let message = viewModel.signUpFlow.httpError?.message ?? "잠시 후 다시 시도해 주세요"
                alertProvider.present("회원가입 실패")
                    .message("잠시 후 다시 시도해 주세요")
                    .show()
            default:
                break
            }
        }
        .onReceive(viewModel.$sendEmailFlow) {
            if case .failure = $0 {
                alertProvider.present("이메일 전송 실패")
                    .show()
            }
        }
    }
    
    private func convertSecondsToTime(timeInSeconds: Int) -> String {
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
