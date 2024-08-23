import Domain
import Foundation
import DIContainer

public final class CreateGroupChatViewModel: BaseViewModel<CreateGroupChatViewModel.CreateGroupChatSubject> {
    
    public enum CreateGroupChatSubject {
        case createdPersonalChat(room: Room)
    }
    
    // MARK: - Repo
    @Inject private var workspaceRepo: WorkspaceRepo
    @Inject private var chatRepo: ChatRepo
    
    // MARK: - State
    @Published var isFetchMembers = false
    @Published var members: FetchFlow<[RetrieveProfile]> = .fetching
    @Published var selectedMembers: [RetrieveProfile] = []
    @Published var roomName = ""
    @Published var createFlow: IdleFlow<Bool> = .idle
    
    func fetchWorkspaceMembers(
        workspaceId: String,
        memberId: Int
    ) {
        sub(workspaceRepo.getMembers(workspaceId: workspaceId)) {
            self.isFetchMembers = true
            self.members = .fetching
        } success: { response in
            let members = response.data.filter { $0.member.id != memberId }
            self.members = .success(members)
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
    
    func createGroupChat(workspaceId: String) {
        if selectedMembers.count == 1 {
            // TODO: create Personal Chat
            return
        }
        
        let joinUsers = selectedMembers.map { $0.member.id }
        sub(chatRepo.createGroup(roomName: roomName, workspaceId: workspaceId, joinUsers: joinUsers, chatRoomImg: "")) {
            self.createFlow = .fetching
        } success: { _ in
            self.createFlow = .success()
        } failure: { error in
            self.createFlow = .failure(error)
        }
    }
    
    func createPersonalChat(workspaceId: String) {
        let joinUsers = selectedMembers.map { $0.member.id }
        sub(chatRepo.createPersonal(roomName: "", workspaceId: workspaceId, joinUsers: joinUsers, chatRoomImg: "")) {
            self.createFlow = .fetching
        } success: { [self] res in
            let roomId = res.data
            sub(chatRepo.searchPersonal(roomId: roomId)) {
                self.createFlow = .fetching
            } success: { res in
                self.emit(.createdPersonalChat(room: res.data))
            } failure: { error in
                self.createFlow = .failure(error)
            }
        } failure: { error in
            self.createFlow = .failure(error)
        }
    }
}
