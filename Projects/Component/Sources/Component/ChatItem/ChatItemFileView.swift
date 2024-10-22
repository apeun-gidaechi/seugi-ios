import SwiftUI
import SwiftUIUtil
import SwiftUtil
import Domain

public struct ChatItemFileView: View {
    private let type: ChatItemAuthorType
    private let message: Message
    private let action: () -> Void
    
    public init(
        type: ChatItemAuthorType,
        message: Message,
        action: @escaping () -> Void
    ) {
        self.type = type
        self.message = message
        self.action = action
    }
    
    private var title: String {
        message.message.split(separator: MessageConstant.fileSeparator)
            .getOrNil(idx: 1)
            .map(String.init) ?? "(제목 없음)"
    }
    
    public var body: some View {
        ChatItemContainer(
            type: type,
            message: message
        ) {
            Button(action: action) {
                HStack(spacing: 8) {
                    Image(icon: .fileLine)
                        .resizable()
                        .renderingMode(.template)
                        .seugiColor(.sub(.white))
                        .frame(width: 24, height: 24)
                        .padding(4)
                        .seugiBackground(.primary(.p500))
                        .clipShape(Circle())
                    VStack(alignment: .leading, spacing: 2) {
                        Text(title)
                            .font(.body(.b1))
                            .seugiColor(.sub(.black))
                        let file = File(message: message.message)
                        if let volume = file.volume,
                           let size = file.size {
                            Text(String(format: "%0.2f", size) + " \(volume.text)")
                                .font(.caption(.c2))
                                .seugiColor(.gray(.g500))
                        }
                    }
                    Image(icon: .expandStopDownLine)
                        .resizable()
                        .renderingMode(.template)
                        .seugiColor(.gray(.g500))
                        .frame(width: 24, height: 24)
                }
                .padding(12)
                .frame(minWidth: 128) // TODO: 디자인 따라 적용
                .seugiBackground(.sub(.white))
                .cornerRadius(12, corners: .allCorners)
                .shadow(.evBlack(.ev1))
            }
            .addTimeLabel(alignment: type.alignent, message: message)
        }
    }
}
