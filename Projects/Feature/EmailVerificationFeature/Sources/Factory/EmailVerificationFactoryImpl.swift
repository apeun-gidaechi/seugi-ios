import SwiftUI
import EmailVerificationFeatureInterface

final class EmailVerificationFactoryImpl: EmailVerificationFactory {
    func makeView(name: String, email: String, password: String) -> some View {
        EmailVerificationCoordinator(name: name, email: email, password: password)
    }
}
