import SwiftUI

public struct SeugiToggle: View {
    @Binding private var isOn: Bool
    private let type: ToggleType
    
    public init(
        isOn: Binding<Bool>,
        type: ToggleType = .default
    ) {
        self._isOn = isOn
        self.type = type
    }
    
    public var body: some View {
        Group {
            switch type {
            case .default:
                Toggle("", isOn: $isOn)
            case .checkbox(let size):
                Toggle("", isOn: $isOn)
                    .toggleStyle(SeugiCheckboxStyle(size: size))
            }
        }
        .tint(isOn ? Color.seugi(.primary(.p500)) : Color.seugi(.gray(.g200)))
        .fixedSize()
    }
}

struct SeugiCheckboxStyle: ToggleStyle {
    var size: ToggleSize
    
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            HStack {
                Image(icon: configuration.isOn ? .checkCircleFill : .checkCircleLine)
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: size.rawValue, height: size.rawValue)
                    .seugiColor(configuration.isOn ? .primary(.p500) : .gray(.g500))
                configuration.label
            }
        }
    }
}
