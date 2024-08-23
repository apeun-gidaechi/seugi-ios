import SwiftUI

final class JoinWorkspaceFactoryImpl: JoinWorkspaceFactory {
    func makeView() -> some View {
        JoinWorkspaceCoordinator()
    }
}
