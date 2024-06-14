import Foundation
import Domain
import DIContainer

public final class JoinWorkspaceManager: ObservableObject {
    
    // MARK: - UseCase
//    @Inject private var joinWorkspaceUseCase: any JoinWorkspaceUseCase
//    @Inject private var getWorkspaceByCode: any GetWorkspaceByCodeUseCase
    
    // MARK: - State
    /* dialog */
    @Published public var showFetchFailureDialog = false
    
    /* fetch flow */
//    @Published public var workspace: FetchFlow<Workspace> = .fetching
    @Published public var isFetchingWorkspace = false
    @Published public var joinFlow: IdleFlow<Bool> = .idle
    
    /* state */
//    @Published public var roleType = WorkspaceRoleType.STUDENT
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
//            let workspace = try await getWorkspaceByCode(code: code)
//            self.workspace = .success(workspace)
//            print(workspace)
        } catch {
            print(error)
            showFetchFailureDialog = true
        }
    }
    
    @MainActor
    public func joinWorkspace() async {
        joinFlow = .fetching
//        guard case .success(let workspace) = workspace else {
//            joinFlow = .idle
//            return
//        }
        do {
//            let request = JoinWorkspaceRequest(workspaceId: workspace.workspaceId, workspaceCode: code, role: roleType)
//            try await joinWorkspaceUseCase(request)
            joinFlow = .success(true)
        } catch {
            print(error)
            joinFlow = .failure
        }
    }
}
