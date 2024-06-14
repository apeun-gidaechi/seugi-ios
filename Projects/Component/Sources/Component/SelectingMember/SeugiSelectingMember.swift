import SwiftUI
import SwiftUIUtil

public struct SeugiSelectingMember: View {
    
    private let action: () -> Void
    
    public init(
        action: @escaping () -> Void
    ) {
        self.action = action
    }
    
    public var body: some View {
        HStack(spacing: 4) {
            Text("노영재 1세")
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
