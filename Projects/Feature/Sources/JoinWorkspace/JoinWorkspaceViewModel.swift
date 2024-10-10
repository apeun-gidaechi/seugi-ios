import Foundation
import Domain
import DIContainer
import SwiftUtil
import Combine

public final class JoinWorkspaceViewModel: ObservableObject {
    var subscriptions = Set<AnyCancellable>()
    
    @Inject private var workspaceRepo: WorkspaceRepo
    
    @Published var workspace: Flow<WorkspaceInfo> = .idle
    
    @Published public var joinFlow: Flow<BaseVoid> = .idle
    @Published var roleType = WorkspaceRole.student
    @Published public var code: String = ""
    public var isFetchJoinWorkspace: Bool {
        joinFlow == .fetching
    }
    public var isInValidInput: Bool {
        code.count < 6
    }
}

extension JoinWorkspaceViewModel {
    public func fetchWorkspace() {
        workspaceRepo.getWorkspace(code: code)
            .map(\.data)
            .flow(\.workspace, on: self)
            .silentSink()
            .store(in: &subscriptions)
    }
    
    public func joinWorkspace() {
        guard case .success(let workspace) = workspace else {
            Log.info("💎 JoinWorkspaceViewModel.joinWorkspace - workspace not founded")
            return
        }
        workspaceRepo.joinWorkspace(
            workspaceId: workspace.workspaceId,
            workspaceCode: code,
            role: roleType
        )
        .flow(\.joinFlow, on: self)
        .silentSink()
        .store(in: &subscriptions)
    }
}
