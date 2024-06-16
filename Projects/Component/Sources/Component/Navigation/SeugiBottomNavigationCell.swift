import SwiftUIUtil
import SwiftUI

struct SeugiBottomNavigationCell: View {
    
    let cellData: SeugiBottomNavigationCellData
    let isSelected: Bool
    
    init(
        cellData: SeugiBottomNavigationCellData,
        isSelected: Bool
    ) {
        self.cellData = cellData
        self.isSelected = isSelected
    }
    
    var body: some View {
        
        let imageColor: Color = isSelected ? .seugi(.primary(.p500)) : .seugi(.gray(.g300))
        let textColor: Color = isSelected ? .seugi(.primary(.p500)) : .seugi(.gray(.g500))
        
        VStack(spacing: 0) {
            Image(icon: cellData.type.image)
                .renderingMode(.template)
                .resizable()
                .frame(width: 28, height: 28)
                .padding(.top, 4)
                .foregroundStyle(imageColor)
                .overlay {
                    if cellData.hasBadge {
                        SeugiBadge(type: .normal)
                            .toTop()
                            .toTrailing()
                            .offset(x: 4, y: -2)
                    }
                }
            Text(cellData.type.text)
                .font(.caption(.c2))
                .foregroundStyle(textColor)
        }
        .padding(.horizontal, 4)
    }
}