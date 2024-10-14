import Foundation
import Domain
import DIContainer
import SwiftUtil
import Combine

final class CreateWorkspaceViewModel: ObservableObject {
    var subscriptions = Set<AnyCancellable>()
    
    @Inject private var workspaceRepo: WorkspaceRepo
    
    @Published var workspaceName: String = ""
    @Published var createWorkspaceFlow: Flow<BaseVoid> = .idle
    
    func createWorkspace(imageUrl: String) {
        // TODO: Add workspace image url
        workspaceRepo.createWorkspace(
            workspaceName: workspaceName,
            workspaceImageUrl: imageUrl
        )
        .flow(\.createWorkspaceFlow, on: self)
        .silentSink()
        .store(in: &subscriptions)
    }
}
