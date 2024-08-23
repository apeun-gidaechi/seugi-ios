import SwiftUI

class OnboardingFactoryImpl: OnboardingFactory {
    func makeView() -> some View {
        OnboardingCoordinator()
    }
}
