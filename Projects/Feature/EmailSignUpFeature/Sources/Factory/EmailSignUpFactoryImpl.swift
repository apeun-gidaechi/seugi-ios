import SwiftUI
import EmailSignUpFeatureInterface

final class EmailSignUpFactoryImpl: EmailSignUpFactory {
    func makeView() -> some View {
        EmailSignUpCoordinator()
    }
}
