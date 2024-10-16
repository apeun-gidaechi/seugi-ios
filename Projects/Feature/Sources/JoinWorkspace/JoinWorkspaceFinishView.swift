import SwiftUI
import Component

struct JoinWorkspaceFinishView {
    @EnvironmentObject private var router: RouterViewModel
}

extension JoinWorkspaceFinishView: View {
    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .trailing, spacing: 16) {
                VStack(spacing: 8) {
                    Image(image: .school)
                        .resizable()
                        .frame(width: 145, height: 145)
                    Text("학교 가입 신청 완료")
                        .font(.subtitle(.s1))
                }
                SeugiToolTip(type: .left, size: .large, direction: .top, text: "가입 수락을 대기중이에요")
            }
            .toCenter()
            Spacer()
            SeugiButton.large("완료", type: .primary) {
                router.navigateToRoot()
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 16)
        }
        .seugiTopBar(title: "학교 가입")
    }
}
