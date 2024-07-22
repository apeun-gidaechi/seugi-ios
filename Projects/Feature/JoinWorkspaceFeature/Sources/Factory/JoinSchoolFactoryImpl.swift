import SwiftUI
import JoinWorkspaceFeatureInterface

final class JoinSchoolFactoryImpl: JoinSchoolFactory {
    func makeView() -> some View {
        JoinSchoolCoordinator()
    }
}
