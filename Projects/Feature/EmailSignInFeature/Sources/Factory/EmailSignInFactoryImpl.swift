import SwiftUI
import EmailSignInFeatureInterface

final class EmailSignInFactoryImpl: EmailSignInFactory {
    func makeView() -> some View {
        EmailSignInCoordinator()
    }
}
