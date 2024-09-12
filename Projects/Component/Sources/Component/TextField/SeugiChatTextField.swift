import SwiftUIUtil
import SwiftUI
import PhotosUI

public struct SeugiChatTextField: View {
    
    public enum Action {
        case sendMessage
        case imageMenu
        case fileMenu
    }
    
    @Binding private var text: String
    
    private let action: (Action) -> Void
    private let hint: String
    
    public init(
        _ hint: String,
        text: Binding<String>,
        action: @escaping (Action) -> Void
    ) {
        self.hint = hint
        self._text = text
        self.action = action
    }
    
    public var body: some View {
        HStack {
            Menu {
                Button("이미지", systemImage: "photo") {
                    action(.imageMenu)
                }
                Button("파일", systemImage: "folder") {
                    action(.fileMenu)
                }
            } label: {
                Image(icon: .addFill)
                    .resizable()
                    .renderingMode(.template)
                    .seugiColor(.gray(.g400))
                    .frame(width: 32, height: 32)
            }
            TextField(hint, text: $text)
                .autocorrectionDisabled()
                .font(.subtitle(.s2))
                .textInputAutocapitalization(.never)
                .textContentType(.init(rawValue: ""))
                .frame(maxWidth: .infinity)
                .frame(height: 32)
                .seugiColor(.sub(.black))
                .tint(.seugi(.primary(.p500)))
            let sendButtonColor: Color.SeugiColorSystem = text.isEmpty ? .gray(.g400) : .primary(.p500)
            Button {
                action(.sendMessage)
            } label: {
                Image(icon: .sendFill)
                    .resizable()
                    .renderingMode(.template)
                    .seugiColor(sendButtonColor)
                    .frame(width: 32, height: 32)
            }
            .disabled(text.isEmpty)
        }
        .padding(.horizontal, 8)
        .frame(height: 56)
        .background(Color.seugi(.sub(.white)))
        .cornerRadius(12, corners: .allCorners)
        .shadow(.evBlack(.ev1))
    }
}
