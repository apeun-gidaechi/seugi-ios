import SwiftUI
import DesignSystem
import BaseFeatureInterface

public struct WaitingJoinView: View {
    
    @EnvironmentObject private var router: Router
    
    public init() {}
    
    public var body: some View {
        VStack(spacing: 16) {
            Spacer()
            VStack {
                Text("학생이신가요?\n아니면 선생님이신가요?")
                    .font(.subtitle(.s1))
                    .toLeading()
                    .padding(.leading, 4)
            }
            .padding(.horizontal, 16)
            Spacer()
            SeugiButton.large("계속하기", type: .gray) {}
            .padding(.horizontal, 20)
            .padding(.bottom, 16)
        }
        .seugiTopBar("")
    }
}
