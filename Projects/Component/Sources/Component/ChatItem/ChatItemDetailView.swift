import SwiftUI
import SwiftUIUtil
import Domain

public struct ChatItemDetailView: View {
    private let message: Message
    
    public init(message: Message) {
        self.message = message
    }
    
    public var body: some View {
        if let detailText = message.detailText {
            Text(detailText)
                .font(.caption(.c2))
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.seugi(.gray(.g100)))
                .cornerRadius(24, corners: .allCorners)
                .padding(.vertical, 12)
                .toHorizontal()
        }
    }
}
