import Foundation
import WorkspaceDomainInterface
import DIContainerInterface

public final class JoinWorkspaceManager: ObservableObject {
    
    // MARK: - UseCase
    @Inject private var joinWorkspaceUseCase: any JoinWorkspaceUseCase
    @Inject private var getWorkspaceByCode: any GetWorkspaceByCodeUseCase
    
    // MARK: - State
    /* dialog */
    @Published public var showFailureDialog = false
    @Published public var showFetchFailureDialog = false
    
    /* fetch flow */
    @Published public var workspace: FetchFlow<Workspace> = .fetching
    @Published public var isFetchingWorkspace = false
    
    /* state */
    @Published public var roleType = WorkspaceRoleType.STUDENT
    @Published public var code = ""
    
    public var isInValidInput: Bool {
        code.count < 6
    }
    
    public init() {}
    
    @MainActor
    public func fetchWorkspace() async {
        isFetchingWorkspace = true
        defer { isFetchingWorkspace = false }
        do {
            let workspace = try await getWorkspaceByCode(code: code)
            self.workspace = .success(data: workspace)
        } catch {
            showFetchFailureDialog = true
        }
    }
    
    @MainActor
    public func joinWorkspace() async {
        guard case .success(let workspace) = workspace else {
            return
        }
        do {
            let request = JoinWorkspaceRequest(workspaceId: workspace.workspaceId, workspaceCode: code, role: roleType)
            try await joinWorkspaceUseCase(request)
        } catch {
            showFailureDialog = true
        }
    }
}
