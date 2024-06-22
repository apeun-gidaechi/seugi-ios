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
    @Published var selectedMembers: [RetrieveProfile] = []
    
    func fetchWorkspaceMembers(workspaceId: String) {
        sub(workspaceRepo.getMembers(workspaceId: workspaceId)) {
            self.isFetchMembers = true
        } success: {
            self.members = .success($0.data)
        } failure: {
            self.members = .failure($0)
        }
    }
    
    func selectMember(member: RetrieveProfile, selected: Bool) {
        if !selected {
            selectedMembers.append(member)
        } else {
            removeMember(member: member)
        }
    }
    
    func removeMember(member: RetrieveProfile) {
        selectedMembers = selectedMembers.filter {
            $0.member.id != member.member.id
        }
    }
}
