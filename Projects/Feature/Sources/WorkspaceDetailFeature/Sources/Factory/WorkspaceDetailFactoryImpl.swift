import SwiftUI

final class WorkspaceDetailFactoryImpl: WorkspaceDetailFactory {
    func makeView() -> some View {
        WorkspaceDetailCoordinator()
    }
}
