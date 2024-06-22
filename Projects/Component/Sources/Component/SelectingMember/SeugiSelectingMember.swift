import SwiftUI
import SwiftUIUtil
import Domain

public struct SeugiSelectingMember: View {
    
    private let action: () -> Void
    private let member: RetrieveProfile
    
    public init(
        member: RetrieveProfile,
        action: @escaping () -> Void
    ) {
        self.action = action
        self.member = member
    }
    
    public var body: some View {
        HStack(spacing: 4) {
            Text(member.member.name)
                .font(.body(.b2))
                .seugiColor(.gray(.g600))
            Button {
                action()
            } label: {
                Image(icon: .closeLine)
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 16, height: 16)
                    .seugiColor(.gray(.g600))
            }
        }
        .padding(8)
        .seugiBackground(.gray(.g100))
        .cornerRadius(12, corners: .allCorners)
    }
}
