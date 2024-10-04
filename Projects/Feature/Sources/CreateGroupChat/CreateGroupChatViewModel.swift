import Domain
import Foundation
import DIContainer
import SwiftUtil
import Combine

public final class CreateGroupChatViewModel: ObservableObject {
    var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Repo
    @Inject private var workspaceRepo: WorkspaceRepo
    @Inject private var chatRepo: ChatRepo
    
    // MARK: - State
    @Published var members: Flow<[RetrieveProfile]> = .fetching
    @Published var selectedMembers: [RetrieveProfile] = []
    @Published var roomName: String = ""
    @Published var createRoomFlow: Flow<String> = .idle
    
    func fetchWorkspaceMembers(
        workspaceId: String,
        memberId: Int
    ) {
        workspaceRepo.getMembers(workspaceId: workspaceId)
            .map { $0.data.filter { $0.member.id != memberId } }
            .flow(\.members, on: self)
            .silentSink()
            .store(in: &subscriptions)
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
        chatRepo.createGroup(
            .init(roomName: roomName, workspaceId: workspaceId, joinUsers: joinUsers, chatRoomImg: "")
        )
        .map(\.data)
        .flow(\.createRoomFlow, on: self)
        .silentSink()
        .store(in: &subscriptions)
    }
    
    func createPersonalChat(workspaceId: String) {
        let joinUsers = selectedMembers.map { $0.member.id }
        self.createRoomFlow = .fetching
        chatRepo.createPersonal(
            .init(roomName: "", workspaceId: workspaceId, joinUsers: joinUsers, chatRoomImg: "")
        )
        .map(\.data)
        .flow(\.createRoomFlow, on: self)
        .silentSink()
        .store(in: &subscriptions)
    }
}
