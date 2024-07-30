import SwiftUI
import CreateWorkspaceFeatureInterface

final class CreateWorkspaceFactoryImpl: CreateWorkspaceFactory {
    func makeView() -> some View {
        CreateWorkspaceCoordinator()
    }
}
