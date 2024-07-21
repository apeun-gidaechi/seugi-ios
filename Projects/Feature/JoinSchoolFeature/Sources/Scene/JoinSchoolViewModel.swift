import Foundation
import Domain
import DIContainer
import BaseFeatureInterface

public final class JoinSchoolViewModel: BaseViewModel<JoinSchoolViewModel.JoinWorkspaceSubject> {
    
    public enum JoinWorkspaceSubject {
        case fetchWorkspaceSuccess
        case joinWorkspaceSuccess
    }
    
    // MARK: - Repo
    @Inject private var workspaceRepo: WorkspaceRepo
    
    // MARK: - State
    /* workspace */
    @Published public var isFetchFailure = false
    @Published var workspace: IdleFlow<Workspace> = .idle
    public var isFetchWorkspace: Bool {
        workspace == .fetching
    }
    
    /* join */
    @Published public var joinFlow: IdleFlow<Bool> = .idle
    @Published var roleType = WorkspaceRole.student
    @Published public var code = ""
    public var isFetchJoinWorkspace: Bool {
        joinFlow == .fetching
    }
    public var isInValidInput: Bool {
        code.count < 6
    }
    
    // MARK: - Method
    public func fetchWorkspace() {
        sub(workspaceRepo.getWorkspace(code: code)) {
            self.workspace = .fetching
        } success: { res in
            self.workspace = .success(res.data)
            self.emit(.fetchWorkspaceSuccess)
        } failure: { error in
            self.isFetchFailure = true
            self.workspace = .failure(error)
        }
    }
    
    public func joinWorkspace() {
        guard case .success(let w) = workspace else {
            print("💎 JoinSchoolViewModel.joinWorkspace - workspace not founded")
            return
        }
        sub(workspaceRepo.joinWorkspace(workspaceId: w.workspaceId, workspaceCode: code, role: roleType)) {
            self.joinFlow = .fetching
        } success: { _ in
            self.joinFlow = .success(true)
            self.emit(.joinWorkspaceSuccess)
        } failure: { error in
            self.joinFlow = .failure(error)
        }
    }
}
