import SwiftUIUtil
import SwiftUI

struct BottomNavigationCell: View {
    private let page: Page
    private let selected: Bool
    
    init(
        page: Page,
        selected: Bool
    ) {
        self.page = page
        self.selected = selected
    }
    
    var body: some View {
        let imageColor: Color = selected ? .seugi(.primary(.p500)) : .seugi(.gray(.g300))
        
        VStack(spacing: 0) {
            Image(icon: page.icon)
                .renderingMode(.template)
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundStyle(imageColor)
                .overlay {
                    if page.hasBadge {
                        SeugiBadge(type: .normal)
                            .toTop()
                            .toTrailing()
                            .offset(x: 4, y: -2)
                    }
                }
            // bottom nav text
            // android version app에는 있음
            // ios는 없는 게 이뻐서 그냥 지움
//            Text(cellData.type.text)
//                .font(.caption(.c2))
//                .foregroundStyle(textColor)
        }
        .padding(.horizontal, 4)
    }
}
