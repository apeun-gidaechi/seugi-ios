import SwiftUI
import DesignSystem
import BaseFeatureInterface

public struct WaitingJoinView: View {
    
    @EnvironmentObject private var router: Router
    
    public init() {}
    
    public var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .trailing, spacing: 16) {
                VStack(spacing: 8) {
                    Image(image: .school)
                        .resizable()
                        .frame(width: 145, height: 145)
                    Text("대구소프트웨어마이스터고등학교")
                        .font(.subtitle(.s1))
                }
                SeugiToolTip(type: .left, size: .large, direction: .top, text: "가입 수락을 대기중이에요")
            }
            .toCenter()
            Spacer()
            SeugiButton.large("확인", type: .gray) {}
            .padding(.horizontal, 20)
            .padding(.bottom, 16)
        }
        .seugiTopBar("")
    }
}
