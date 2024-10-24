import SwiftUI

import SwiftUIUtil

public struct SeugiTextField: View {
    private let hint: String
    @Binding var text: String
    private let type: SeugiTextFieldType
    
    @FocusState private var isFocused: Bool
    @State private var isHide = true
    
    public init(
        _ hint: String = "",
        text: Binding<String>,
        type: SeugiTextFieldType = .none(hasXMark: true)
    ) {
        self.hint = hint
        self._text = text
        self.type = type
    }
    
    public var body: some View {
        Group {
            if type == .password && isHide {
                SecureField(hint,
                            text: $text)
            } else {
                TextField(hint,
                          text: $text)
            }
        }
        .textFieldStyle(
            SeugiTextFieldStyle(
                text: text,
                isFocused: isFocused,
                isHide: isHide,
                type: type
            ) {
                text = ""
            } onClickHide: {
                isHide.toggle()
            }
        )
        .focused($isFocused)
    }
}

struct SeugiTextFieldStyle: TextFieldStyle {
    @Environment(\.isEnabled) var isEnabled
    var text: String
    var isFocused: Bool
    var isHide: Bool
    var type: SeugiTextFieldType
    var onClickClose: () -> Void
    var onClickHide: () -> Void
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        let lineWidth = isFocused ? 1.5 : 1
        let strokeColor: Color = isFocused ? .seugi(.primary(.p500)) : .seugi(.gray(.g300))
        return configuration
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .textContentType(.init(rawValue: ""))
            .frame(height: 52)
            .background(Color.seugi(.sub(.white)))
            .padding(.horizontal, 16)
            .cornerRadius(12, corners: .allCorners)
            .font(.subtitle(.s2))
            .accentColor(.seugi(.primary(.p500)))
            .seugiColor(isEnabled ? .sub(.black) : .gray(.g400))
            .overlay {
                ZStack {
                    RoundedCornerShape(radius: 12)
                        .stroke(isEnabled ? strokeColor : .seugi(.gray(.g200)), lineWidth: lineWidth)
                    HStack(spacing: 0) {
                        Spacer()
                        switch type {
                        case .none(let hasXMark):
                            if hasXMark && !text.isEmpty {
                                Image(icon: .closeFill)
                                    .resizable()
                                    .renderingMode(.template)
                                    .frame(width: 28, height: 28)
                                    .seugiColor(.gray(.g500))
                                    .onTapGesture {
                                        onClickClose()
                                    }
                            }
                        case .password:
                            Image(icon: isHide ? .hideFill : .showFill)
                                .resizable()
                                .renderingMode(.template)
                                .frame(width: 28, height: 28)
                                .seugiColor(.gray(.g500))
                                .onTapGesture {
                                    onClickHide()
                                }
                        }
                    }
                    .padding(.trailing, 16)
                }
            }
    }
}
