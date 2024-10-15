import SwiftUI
import Component

struct ProfileEditSheetView: View {
    private let title: String
    @Binding private var text: String
    private var editAction: () -> Void
    
    init(
        title: String,
        text: Binding<String>,
        editAction: @escaping () -> Void
    ) {
        self.title = title
        self._text = text
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
            }
            SeugiButton.large("저장", type: .primary) {
                editAction()
            }
        }
        .padding(20)
        .presentationDetents([.height(220)])
    }
}
