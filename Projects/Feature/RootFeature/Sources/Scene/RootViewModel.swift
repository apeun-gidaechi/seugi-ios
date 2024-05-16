import Foundation
import DIContainerInterface
import WorkspaceDomainInterface

public final class RootViewModel: ObservableObject {
    
    @Inject private var getWorkspacesUseCase: any GetWorkspacesUseCase
    
    public init() {}
    
    @MainActor
    func fetchWorkspaces() async {
        
    }
}
