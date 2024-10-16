import SwiftUI
import Component

struct RegisterOAuthView {
    @EnvironmentObject private var router: RouterViewModel
    
    @StateObject private var viewModel: RegisterOAuthViewModel
    
    @FocusState private var firstTextField: Bool
    
    public init(viewModel: RegisterOAuthViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
    }
}

extension RegisterOAuthView: View {
    var body: some View {
        VStack(spacing: 16) {
            SeugiTextFieldForm(
                "이름을 입력해 주세요",
                text: $viewModel.name,
                label: "이름"
            )
            .padding(.top, 16)
            .focused($firstTextField)
            Spacer()
            Button {
                router.navigateToRoot()
            } label: {
                Text("이미 계정이 있으신가요?")
                    .seugiColor(.primary(.p500))
                    .font(.body(.b1))
            }
            SeugiButton.large("계속하기", type: .primary) {
                // handle sign up
            }
            .padding(.bottom, 16)
        }
        .padding(.horizontal, 20)
        .seugiTopBar(title: "회원가입")
        .onAppear {
            firstTextField = true
        }
    }
}
