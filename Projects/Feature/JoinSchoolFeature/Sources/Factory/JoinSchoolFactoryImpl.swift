import SwiftUI
import JoinSchoolFeatureInterface

final class JoinSchoolFactoryImpl: JoinSchoolFactory {
    func makeView() -> some View {
        JoinSchoolCoordinator()
    }
}
