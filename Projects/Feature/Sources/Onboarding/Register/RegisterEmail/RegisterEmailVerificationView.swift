import SwiftUI
import Component

public struct RegisterEmailVerificationView {
    enum FocusedField {
        case verificationCode
    }
    
    @EnvironmentObject private var alertProvider: AlertProvider
    @EnvironmentObject private var router: RouterViewModel
    @EnvironmentObject private var appState: AppViewModel
    @EnvironmentObject private var viewModel: RegisterEmailViewModel
    
    @StateObject private var timerManager = TimerManager()
    
    @FocusState private var focused: FocusedField?
    
    public init() {}
}

extension RegisterEmailVerificationView: View {
    public var body: some View {
        VStack(spacing: 8) {
            SeugiCodeTextFieldForm(
                text: $viewModel.verificationCode,
                label: "인증코드",
                length: 6
            )
            .keyboardType(.numberPad)
            .focused($focused, equals: .verificationCode)
            .padding(.top, 16)
            emailSend()
                .toTrailing()
            Spacer()
        }
        .padding(.horizontal, 20)
        .seugiTopBar(title: "이메일 인증")
        .safeAreaInset(edge: .bottom) {
            SeugiButton.large(
                "계속하기",
                type: .primary,
                isLoading: viewModel.signUpFlow.is(.fetching)
            ) {
                viewModel.signUp()
            }
            .disabled(viewModel.isInValidCodeInput)
            .padding(.bottom, 16)
        }
        .onAppear {
            focused = .verificationCode
        }
        .onReceive(viewModel.$signUpFlow) { flow in
            switch flow {
            case .success(let token):
                appState.accessToken = String(token.accessToken.split(separator: " ")[1])
                appState.refreshToken = String(token.refreshToken.split(separator: " ")[1])
                router.navigateToRoot()
            case .failure:
                alertProvider.present(
                    .init(title: "회원가입 실패")
                    .message("잠시 후 다시 시도해 주세요")
                )
            default:
                break
            }
        }
        .onReceive(viewModel.$sendEmailFlow) {
            if case .failure = $0 {
                alertProvider.present(
                    .init(title: "이메일 전송 실패")
                )
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
