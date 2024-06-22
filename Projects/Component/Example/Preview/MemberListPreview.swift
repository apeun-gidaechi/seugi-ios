import SwiftUI
import Component
import DomainTesting

public struct MemberListPreview: View {
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                SeugiMemberList(type: .normal, member: .mock())
                SeugiMemberList(type: .normal, member: .mock()) {
                    Image(icon: .checkLine)
                        .renderingMode(.template)
                        .seugiColor(.primary(.p500))
                }
                SeugiMemberList(type: .invitation, member: .mock())
            }
        }
    }
}
