import Foundation
import Domain
import DIContainer
import SwiftUtil

public final class JoinWorkspaceViewModel: BaseViewModel<JoinWorkspaceViewModel.Effect> {
    
    public enum Effect {}
    
    // MARK: - Repo
    @Inject private var workspaceRepo: WorkspaceRepo
    
    // MARK: - State
    // workspace
    @Published var workspace: Flow<WorkspaceInfo> = .idle
    
    // join
    @Published public var joinFlow: Flow<Bool> = .idle
    @Published var roleType = WorkspaceRole.student
    @Published public var code: String = ""
    public var isFetchJoinWorkspace: Bool {
        joinFlow == .fetching
    }
    public var isInValidInput: Bool {
        code.count < 6
    }
    
    // MARK: - Method
    public func fetchWorkspace() {
        workspaceRepo.getWorkspace(code: code)
            .map(\.data)
            .flow(\.workspace, on: self)
            .silentSink()
            .store(in: &subscriptions)
    }
    
    public func joinWorkspace() {
        guard case .success(let w) = workspace else {
            Log.info("💎 JoinWorkspaceViewModel.joinWorkspace - workspace not founded")
            return
        }
        workspaceRepo.joinWorkspace(workspaceId: w.workspaceId, workspaceCode: code, role: roleType)
            .map { _ in true }
            .flow(\.joinFlow, on: self)
            .silentSink()
            .store(in: &subscriptions)
    }
}
