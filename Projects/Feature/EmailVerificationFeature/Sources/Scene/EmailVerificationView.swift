import SwiftUI
import BaseFeatureInterface
import DesignSystem

public struct EmailVerificationView: View {
    
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var timerManager: TimerManager
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
            if viewModel.isWaiting {
                Text(convertSecondsToTime(timeInSeconds: timerManager.timeRemaining))
                    .font(.body(.b2))
                    .seugiColor(.gray(.g600))
                    .toTrailing()
            } else {
                SeugiButton.small("인증 코드 전송", type: .primary) {
                    timerManager.startTimer {
                        viewModel.isWaiting = false
                    }
                    Task {
                        await viewModel.sendEmail()
                    }
                }
                .toTrailing()
            }
            Spacer()
            SeugiButton.large("계속하기", type: .primary) {
                Task {
                    await viewModel.signUp()
                }
            }
            .disabled(viewModel.isInValidInput)
            .padding(.bottom, 16)
        }
        .padding(.horizontal, 20)
        .seugiTopBar("이메일 인증")
        .alertWithAnyView("회원가입 실패", when: failureDialog(for: $viewModel.signUpFlow)) {
            Button("확인", role: .cancel) {}
        }
        .alertWithAnyView("이메일 전송 실패", when: $viewModel.isSendEmailFailure) {
            Button("닫기", role: .cancel) {}
        }
        .onChangeIdleFlow(of: viewModel.signUpFlow) {
            router.navigateToRoot()
        }
    }
    
    func convertSecondsToTime(timeInSeconds: Int) -> String {
        let minutes = timeInSeconds / 60
        let seconds = timeInSeconds % 60
        return String(format: "%02i분 %02i초 남음", minutes, seconds)
    }
}
