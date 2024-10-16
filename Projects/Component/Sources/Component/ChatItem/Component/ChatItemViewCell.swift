import SwiftUI

import SwiftUIUtil

struct ChatItemViewCell: View {
    
    private let text: String
    private let type: ChatItemAuthorType
    
    init(
        text: String,
        type: ChatItemAuthorType
    ) {
        self.text = text
        self.type = type
    }
    
    public var body: some View {
        Text(text)
            .font(.body(.b1))
            .seugiColor(type.foregroundColor)
            .padding(12)
            .background(Color.seugi(type.backgroundColor))
            .cornerRadius(8, corners: type.corners)
            .shadow(.evBlack(.ev1))
            .if(type == .ai) { view in
                view.stroke(8, corners: type.corners, content: SeugiGradientSystem.primary, lineWidth: 1.5)
            }
    }
}
