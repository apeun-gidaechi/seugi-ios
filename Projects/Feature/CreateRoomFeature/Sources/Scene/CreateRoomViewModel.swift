import Domain
import BaseFeatureInterface
import Foundation
import DIContainer

public final class CreateRoomViewModel: BaseViewModel<CreateRoomViewModel.CreateRoomSubject> {
    
    public enum CreateRoomSubject {
        case createSuccess
    }
    
    // MARK: - Repo
    @Inject private var workspaceRepo: WorkspaceRepo
    @Inject private var chatRepo: ChatRepo
    
    // MARK: - State
    @Published var isFetchMembers = false
    @Published var members: FetchFlow<[RetrieveProfile]> = .fetching
    @Published var selectedMembers: [RetrieveProfile] = []
    @Published var roomName = ""
    @Published var createFailure = false
    @Published var fetchCreate = false
    
    func fetchWorkspaceMembers(workspaceId: String) {
        sub(workspaceRepo.getMembers(workspaceId: workspaceId)) {
            self.isFetchMembers = true
            self.members = .fetching
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
    
    func createRoom(workspaceId: String) {
        if selectedMembers.count == 1 {
            // create Personal Chat
            return
        }
        
        let joinUsers = selectedMembers.map { $0.member.id }
        sub(chatRepo.createGroup(roomName: roomName, workspaceId: workspaceId, joinUsers: joinUsers, chatRoomImg: "")) {
            self.fetchCreate = true
        } success: { _ in
            self.emit(.createSuccess)
        } failure: { _ in
            self.createFailure = true
        } finished: {
            self.fetchCreate = false
        }
    }
}
