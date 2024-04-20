import SwiftUI
import BaseFeatureInterface
import DesignSystem

public struct EmailVerificationView: View {
    
    @EnvironmentObject private var router: Router
    @StateObject private var viewModel: EmailVerificationViewModel
    
    public init(
        viewModel: EmailVerificationViewModel
    ) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        VStack(spacing: 8) {
            SeugiCodeTextFieldForm(text: $viewModel.verificationCode, label: "인증코드", length: 6)
                .padding(.top, 16)
            SeugiButton.small("인증 코드 전송", type: .primary) {}
                .toTrailing()
            Spacer()
            SeugiButton.large("계속하기", type: .primary) {
            }
            .padding(.bottom, 16)
        }
        .padding(.horizontal, 20)
        .seugiTopBar("이메일 인증")
    }
}
