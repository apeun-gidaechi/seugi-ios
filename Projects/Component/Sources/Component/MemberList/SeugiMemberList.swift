import SwiftUI

import Domain

public struct SeugiMemberList<Content>: View where Content: View {
    
    private let type: SeugiMemberListType
    private let content: () -> Content
    
    public init(
        type: SeugiMemberListType,
        @ViewBuilder content: @escaping () -> Content = { EmptyView() }
    ) {
        self.type = type
        self.content = content
    }
    
    public var body: some View {
        HStack(spacing: 16) {
            switch type {
            case .normal(let member, let role):
                SeugiAvatar(member.picture, type: .large)
                HStack(spacing: 4) {
                    Text("\(member.name)")
                        .font(.subtitle(.s2))
                        .seugiColor(.sub(.black))
                    switch role {
                    case .middleAdmin, .admin:
                        Image(icon: .crownFill)
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 24, height: 24)
                            .seugiColor(role == .admin ? .orange(.o500) : .yellow(.y500))
                    default:
                        EmptyView()
                    }
                }
            case .invitation:
                Image(icon: .addRingLine)
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 28, height: 28)
                    .seugiColor(.primary(.p400))
                Text("멤버 초대하기")
                    .font(.subtitle(.s2))
                    .seugiColor(.primary(.p400))
            }
            Spacer()
            content()
        }
        .padding(16)
        .background()
    }
}
