import SwiftUI
import Component

struct ProfileEditSheetView: View {
    private let title: String
    @Binding private var text: String
    private let keyboardType: UIKeyboardType
    private let limit: Int?
    private let editAction: () -> Void
    
    init(
        title: String,
        text: Binding<String>,
        keyboardType: UIKeyboardType = .default,
        limit: Int? = nil,
        editAction: @escaping () -> Void
    ) {
        self.title = title
        self._text = text
        self.keyboardType = keyboardType
        self.limit = limit
        self.editAction = editAction
    }
    
    var body: some View {
        VStack(spacing: 32) {
            VStack(alignment: .leading, spacing: 16) {
                Text(title)
                    .padding(.leading, 4)
                    .font(.subtitle(.s2))
                    .seugiColor(.sub(.black))
                SeugiTextField(text: $text)
                    .keyboardType(keyboardType)
            }
            SeugiButton.large("저장", type: .primary) {
                editAction()
            }
        }
        .padding(20)
        .presentationDetents([.height(220)])
        .onChange(of: text) { text in
            guard let limit else { return }
            if text.count > limit {
                self.text = text[0..<limit]
            }
        }
    }
}
