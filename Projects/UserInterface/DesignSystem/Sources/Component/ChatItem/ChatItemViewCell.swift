import SwiftUI

public struct ChatItemViewCell: View {
    
    private var text: String
    private var type: ChatItemViewCellType
    
    public init(text: String,
                type: ChatItemViewCellType) {
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
