import SwiftUI
import EmailVerificationFeatureInterface

final class EmailVerificationFactoryImpl: EmailVerificationFactory {
    func makeView() -> some View {
        EmailVerificationCoordinator()
    }
}
