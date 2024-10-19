import SwiftUI
import Component

struct TimetableSubjectText: View {
    let text: String
    let isTimetableEmpty: Bool
    
    init(text: String, isTimetableEmpty: Bool = false) {
        self.text = text
        self.isTimetableEmpty = isTimetableEmpty
    }
    
    var body: some View {
        if isTimetableEmpty {
            Text(text)
                .font(.footnote)
                .multilineTextAlignment(.center)
                .seugiColor(.sub(.black))
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        } else {
            Text(text)
                .lineLimit(1)
                .truncationMode(.tail)
                .font(.caption)
                .seugiColor(.sub(.black))
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    TimetableSubjectText(text: "test", isTimetableEmpty: true)
}
