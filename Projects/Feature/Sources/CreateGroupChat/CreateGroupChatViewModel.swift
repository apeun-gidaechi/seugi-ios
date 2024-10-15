import Domain
import Foundation
import DIContainer
import SwiftUtil
import Combine

public final class CreateGroupChatViewModel: ObservableObject {
    var subscriptions = Set<AnyCancellable>()
    
    @Inject private var workspaceRepo: WorkspaceRepo
    @Inject private var chatRepo: ChatRepo
    
    @Published var members: Flow<[RetrieveProfile]> = .fetching
    @Published var selectedMembers: [RetrieveProfile] = []
    @Published var roomName: String = ""
    @Published var createRoomFlow: Flow<String> = .idle
    @Published var createdRoom: Flow<Room> = .idle
}

extension CreateGroupChatViewModel {
    var firstMember: RetrieveProfile {
        selectedMembers.first!
    }
    
    var emptyRoomName: String {
        "\(firstMember.nameAndNick) 외 \(selectedMembers.count - 1)명"
    }
}

extension CreateGroupChatViewModel {
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

extension CreateGroupChatViewModel {
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
    
    func createGroupChat(
        workspaceId: String,
        memberId: Int
    ) {
        let joinUsers = selectedMembers.map { $0.member.id } + [memberId]
        chatRepo.createGroup(
            .init(
                roomName: roomName.isEmpty ? emptyRoomName : roomName,
                workspaceId: workspaceId,
                joinUsers: joinUsers,
                chatRoomImg: ""
            )
        )
        .map(\.data)
        .flow(\.createRoomFlow, on: self)
        .ignoreError()
        .sink(receiveValue: self.fetchCreatedGruopRoom)
        .store(in: &subscriptions)
    }
    
    func createPersonalChat(
        workspaceId: String,
        memberId: Int
    ) {
        let joinUsers = selectedMembers.map { $0.member.id } + [memberId]
        self.createRoomFlow = .fetching
        chatRepo.createPersonal(
            .init(
                roomName: "",
                workspaceId: workspaceId,
                joinUsers: joinUsers,
                chatRoomImg: ""
            )
        )
        .map(\.data)
        .flow(\.createRoomFlow, on: self)
        .ignoreError()
        .sink(receiveValue: self.fetchCreatedPersonalRoom)
        .store(in: &subscriptions)
    }
    
    func fetchCreatedPersonalRoom(roomId: String) {
        chatRepo.searchPersonal(roomId: roomId)
            .map(\.data)
            .flow(\.createdRoom, on: self)
            .silentSink()
            .store(in: &subscriptions)
    }
    
    func fetchCreatedGruopRoom(roomId: String) {
        chatRepo.searchGroup(roomId: roomId)
            .map(\.data)
            .flow(\.createdRoom, on: self)
            .silentSink()
            .store(in: &subscriptions)
    }
}
