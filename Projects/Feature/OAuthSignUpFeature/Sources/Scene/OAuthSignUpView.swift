import SwiftUI
import DesignSystem
import BaseFeature
import DIContainerInterface

public struct OAuthSignUpView: View {
    
    @InjectObject private var vm: OAuthSignUpViewModel
    @EnvironmentObject private var router: Router
    
    public var body: some View {
        VStack(spacing: 16) {
            
            SeugiTextFieldForm("이름을 입력해 주세요", text: $vm.name, label: "이름")
                .padding(.top, 16)
            
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
        .seugiTopBar("회원가입")
    }
}
