import SwiftUI

public extension Color {
    enum SeugiColorSystem {
        case primary(Primary)
        case gray(Gray)
        case sub(Sub)
        case red(Red)
        case orange(Orange)
        case yellow(Yellow)
    }
}

public extension Color {
    static func seugi(_ style: SeugiColorSystem) -> Color {
        switch style {
        case let .primary(colorable as SeugiColorable),
             let .gray(colorable as SeugiColorable),
             let .sub(colorable as SeugiColorable),
             let .red(colorable as SeugiColorable),
             let .orange(colorable as SeugiColorable),
            let .yellow(colorable as SeugiColorable):
            return colorable.color
        }
    }
    
    // hex to color
    init(_ hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}

public extension View {
    @inlinable
    func seugiColor(_ style: Color.SeugiColorSystem) -> some View {
        return foregroundStyle(Color.seugi(style))
    }
    
    @inlinable
    func seugiBackground(_ style: Color.SeugiColorSystem) -> some View {
        return background(Color.seugi(style))
    }
    
    @inlinable
    func seugiBackground<T: InsettableShape>(_ style: Color.SeugiColorSystem, in: T) -> some View {
        return background(Color.seugi(style), in: `in`)
    }
}
