import SwiftUI

public final class ProfileFactoryImpl: ProfileFactory {
    public func makeView() -> some View {
        ProfileCoordinator()
    }
}
