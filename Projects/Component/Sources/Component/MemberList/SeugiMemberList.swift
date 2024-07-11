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
            if case .invitation = type {
                Image(icon: .addRingLine)
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 28, height: 28)
                    .seugiColor(.primary(.p400))
            } else {
                SeugiAvatar(type: .large)
            }
            switch type {
            case .normal(let member):
                Text("\(member.name)")
                    .font(.subtitle(.s2))
                    .seugiColor(.sub(.black))
            case .invitation:
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
