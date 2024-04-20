import SwiftUI

public struct ChatItemView: View {
    
    var author: String
    var type: ChatItemViewCellType
    
    public init(author: String, 
                type: ChatItemViewCellType) {
        self.author = author
        self.type = type
    }
    
    public var body: some View {
        HStack {
            if case .me = type {
                Spacer()
            }
            HStack(alignment: .top) {
                if case .other = type {
                    SeugiAvatar(type: .medium)
                }
                VStack(alignment: .leading, spacing: 4) {
                    if type.isLeft {
                        Text(author)
                            .font(.body(.b1))
                            .seugiColor(.gray(.g600))
                    }
                    VStack(alignment: type.isLeft ? .leading : .trailing, spacing: 8) {
                        ChatItemViewCell(text: "iOS 정말 재미있어요!", type: type)
                        ChatItemViewCell(text: "iOS 정말 재미있어요!", type: type)
                        // 마지막 뷰 일때
                        HStack(alignment: .bottom) {
                            if type.isLeft {
                                ChatItemViewCell(text: "iOS 정말 재미있어요!", type: type)
                            }
                            VStack(alignment: type.isLeft ? .leading : .trailing, spacing: 0) {
                                Text("1")
                                    .seugiColor(.gray(.g600))
                                    .font(.caption(.c1))
                                Text("오후 7:44")
                                    .seugiColor(.gray(.g600))
                                    .font(.caption(.c2))
                            }
                            if !type.isLeft {
                                ChatItemViewCell(text: "iOS 정말 재미있어요!", type: type)
                            }
                        }
                    }
                }
            }
            .padding()
            if type.isLeft {
                Spacer()
            }
        }
    }
}
