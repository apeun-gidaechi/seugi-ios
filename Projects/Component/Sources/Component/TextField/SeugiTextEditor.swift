import SwiftUI
import SwiftUIUtil

public struct SeugiTextEditor {
    @Environment(\.isEnabled) var isEnabled
    
    @FocusState private var isFocused: Bool
    @State private var isHide = true
    @Binding var text: String
    
    private let height: CGFloat
    
    public init(
        text: Binding<String>,
        height: CGFloat = 300
    ) {
        self._text = text
        self.height = height
    }
}

extension SeugiTextEditor: View {
    public var body: some View {
        let lineWidth = isFocused ? 1.5 : 1
        let strokeColor: Color = .seugi(isFocused ? .primary(.p500) : .gray(.g300))
        
        TextEditor(text: $text)
            .frame(height: height)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .textContentType(.init(rawValue: ""))
            .padding(8)
            .background(Color.seugi(.sub(.white)))
            .cornerRadius(12, corners: .allCorners)
            .font(.subtitle(.s2))
            .accentColor(.seugi(.primary(.p500)))
            .seugiColor(isEnabled ? .sub(.black) : .gray(.g400))
            .overlay(
                ZStack {
                    RoundedCornerShape(radius: 12)
                        .stroke(isEnabled ? strokeColor : .seugi(.gray(.g200)), lineWidth: lineWidth)
                }
            )
            .focused($isFocused)
    }
}
