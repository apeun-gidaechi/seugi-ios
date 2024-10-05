import SwiftUI

public struct SeugiDivider: View {
    private let thickness: SeugiDividerThickness
    private let direction: SeugiDividerDirection
    
    public init(
        thickness: SeugiDividerThickness = .thin,
        direction: SeugiDividerDirection = .horizontal
    ) {
        self.thickness = thickness
        self.direction = direction
    }
    
    public var body: some View {
        Group {
            switch (thickness, direction) {
            case (.thick, .horizontal):
                Rectangle()
                    .frame(maxWidth: .infinity)
                    .frame(height: 8)
            case (.thick, .vertical):
                Rectangle()
                    .frame(maxHeight: .infinity)
                    .frame(width: 8)
            case (.thin, .horizontal):
                Rectangle()
                    .frame(maxWidth: .infinity)
                    .frame(height: 1)
            case (.thin, .vertical):
                Rectangle()
                    .frame(maxHeight: .infinity)
                    .frame(width: 1)
            }
        }
        .seugiColor(.gray(.g200))
    }
}
