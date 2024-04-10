import SwiftUI
import JoinSuccessFeatureInterface

final class JoinSuccessFactoryImpl: JoinSuccessFactory {
    func makeView() -> some View {
        JoinSuccessCoordinator()
    }
}
