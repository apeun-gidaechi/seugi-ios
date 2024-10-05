import SwiftUI

import SwiftUIUtil

public struct ChatItemDetailView: View {
    private let text: String
    
    public init(text: String) {
        self.text = text
    }
    
    public var body: some View {
        Text(text)
            .font(.caption(.c2))
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(Color.seugi(.gray(.g100)))
            .cornerRadius(24, corners: .allCorners)
            .padding(.vertical, 12)
            .toHorizontal()
    }
}
