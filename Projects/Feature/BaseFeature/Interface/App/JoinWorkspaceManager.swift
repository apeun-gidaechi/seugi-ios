import Foundation
import Domain
import DIContainer

public final class JoinWorkspaceManager: BaseViewModel<JoinWorkspaceManager.JoinWorkspaceSubject> {
    
    public enum JoinWorkspaceSubject {}
    
    // MARK: - Repo
    @Inject private var workspaceRepo: WorkspaceRepo
    
    // MARK: - State
    // workspace
    @Published public var isFetchFailure = false
    @Published var workspace: FetchFlow<Workspace> = .fetching
    public var isFetchWorkspace: Bool {
        workspace == .fetching
    }
    
    // join
    @Published public var joinFlow: IdleFlow<Bool> = .idle
    @Published var roleType = WorkspaceRole.student
    @Published public var code = ""
    public var isInValidInput: Bool {
        code.count < 6
    }
    
    // MARK: - Method
    public func fetchWorkspace() {
        sub(workspaceRepo.getWorkspace(code: code)) {
            self.workspace = .fetching
        } success: { res in
            self.workspace = .success(res.data)
        } failure: { error in
            self.isFetchFailure = true
            self.workspace = .failure(error)
        }
    }
    
    public func joinWorkspace() {
        guard case .success(let w) = workspace else {
            return
        }
        sub(workspaceRepo.joinWorkspace(workspaceId: w.workspaceId, workspaceCode: code, role: roleType)) {
            self.joinFlow = .fetching
        } success: { _ in
            self.joinFlow = .success(true)
        } failure: { error in
            self.joinFlow = .failure(error)
        }
    }
}
