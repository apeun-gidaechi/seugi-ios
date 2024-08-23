import SwiftUI

final class CreateWorkspaceFactoryImpl: CreateWorkspaceFactory {
    func makeView() -> some View {
        CreateWorkspaceCoordinator()
    }
}
