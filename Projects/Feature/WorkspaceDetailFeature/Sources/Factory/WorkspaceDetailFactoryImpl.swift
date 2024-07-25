import SwiftUI
import WorkspaceDetailFeatureInterface

final class WorkspaceDetailFactoryImpl: WorkspaceDetailFactory {
    func makeView() -> some View {
        WorkspaceDetailCoordinator()
    }
}

