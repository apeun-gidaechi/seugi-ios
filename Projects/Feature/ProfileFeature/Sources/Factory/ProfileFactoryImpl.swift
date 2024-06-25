import SwiftUI
import ProfileFeatureInterface

public final class ProfileFactoryImpl: ProfileFactory {
    public func makeView() -> some View {
        ProfileCoordinator()
    }
}
