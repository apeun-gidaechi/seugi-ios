import SwiftUI

public struct SeugiAppIcon: View {
    private let type: SeugiAppIconType
    
    public init(type: SeugiAppIconType) {
        self.type = type
    }
    
    public var body: some View {
        Image(image: .appIcon)
            .resizable()
            .frame(width: type.size, height: type.size)
    }
}
