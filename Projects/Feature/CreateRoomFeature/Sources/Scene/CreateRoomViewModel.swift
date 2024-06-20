import Domain
import BaseFeatureInterface
import Foundation
import DIContainer

public final class CreateRoomViewModel: BaseViewModel<CreateRoomViewModel.CreateRoomSubject> {
    
    public enum CreateRoomSubject {}
    
    // MARK: - Repo
    @Inject private var workspaceRepo: WorkspaceRepo
    
    // MARK: - State
    @Published var isFetchMembers = false
    @Published var members: FetchFlow<[RetrieveProfile]> = .fetching
    
    func fetchWorkspaceMembers(workspaceId: String) {
        sub(workspaceRepo.getMembers(workspaceId: workspaceId)) {
            self.isFetchMembers = true
        } success: {
            self.members = .success($0.data)
        } failure: {
            self.members = .failure($0)
        }
    }
}
