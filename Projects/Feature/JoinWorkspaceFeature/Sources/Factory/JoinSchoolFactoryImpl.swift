import SwiftUI
import JoinWorkspaceFeatureInterface

final class JoinWorkspaceFactoryImpl: JoinWorkspaceFactory {
    func makeView() -> some View {
        JoinWorkspaceCoordinator()
    }
}
