import SwiftUI
import DesignSystem
import BaseFeature

public struct SchoolCodeView: View {
    
    @ObservedObject private var vm: SchoolCodeViewModel
    @EnvironmentObject private var router: Router
    
    public init(vm: SchoolCodeViewModel) {
        self.vm = vm
    }
    
    public var body: some View {
        VStack(spacing: 16) {
            SeugiTextFieldForm("초대코드를 입력해 주세요", text: $vm.code, label: "초대코드")
                .padding(.top, 16)
            Spacer()
            SeugiButton.large("계속하기", type: .primary) {
                router.navigate(to: SchoolCodeDestination.joinSuccess)
            }
            .padding(.bottom, 16)
        }
        .padding(.horizontal, 20)
        .seugiTopBar("학교 가입")
        .hideBackButton()
    }
}
