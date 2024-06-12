import SwiftUI
import OAuthSignUpFeatureInterface

final class OAuthSignUpFactoryImpl: OAuthSignUpFactory {
    func makeView() -> some View {
        OAuthSignUpCoordinator()
    }
}
