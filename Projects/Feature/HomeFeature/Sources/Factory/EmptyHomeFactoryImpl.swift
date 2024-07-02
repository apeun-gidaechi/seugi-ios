import SwiftUI
import HomeFeatureInterface

public final class EmptyHomeFactoryImpl: EmptyHomeFactory {
    public func makeView() -> some View {
        EmptyHomeView()
    }
}
