import SwiftUI
import Component
import SwiftUIUtil

struct JobCell: View {
    
    @Namespace private var animation
    
    private let jobType: JobType
    private let isActive: Bool
    
    init(jobType: JobType, isActive: Bool) {
        self.jobType = jobType
        self.isActive = isActive
    }
    
    var body: some View {
        VStack(spacing: 5) {
            let textColor: Color.SeugiColorSystem = isActive ? .sub(.black) : .gray(.g500)
            HStack(spacing: 4) {
                Text(jobType.rawValue)
                    .font(.subtitle(.s2))
                    .seugiColor(textColor)
                    .matchedGeometryEffect(id: "job label", in: animation)
                if isActive {
                    Image(icon: .checkLine)
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 24, height: 24)
                        .seugiColor(.primary(.p500))
                }
            }
            .frame(height: 24)
            .padding(.top, 17)
            Image(image: jobType.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 120, height: 120)
                .offset(y: 20)
        }
        .frame(height: 189)
        .frame(maxWidth: .infinity)
        .background(Color.seugi(.gray(.g100)))
        .cornerRadius(12, corners: .allCorners)
        .stroke(12, content: isActive ? Color.seugi(.primary(.p500)) : Color.seugi(.gray(.g300)), lineWidth: isActive ? 2 : 1)
        .if(isActive) {
            $0
                .shadow(.evPrimary(.ev3))
        }
    }
}
