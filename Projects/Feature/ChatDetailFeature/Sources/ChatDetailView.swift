import SwiftUI
import DesignSystem

public struct ChatDetailView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    public init() {}
    
    public var body: some View {
        ScrollView {
            VStack {
                ChatItemDateView(date: "2024년 3월 21일 목요일")
                ChatItemView(author: "이강현", type: .other)
                ChatItemView(author: "이강현", type: .me)
                ChatItemView(author: "박재욱", type: .other)
            }
        }
        .seugiToolbar("노영재") {
            dismiss()
        }
    }
}
