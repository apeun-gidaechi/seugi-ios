import SwiftUI
import OnboardingFeatureInterface

class OnboardingFactoryImpl: OnboardingFactory {
    func makeView() -> some View {
        OnboardingCoordinator()
    }
}
