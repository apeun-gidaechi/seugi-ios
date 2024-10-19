import Foundation
import Domain
import DIContainer
import SwiftUtil
import Combine

final class WorkspaceMemberViewModel: ObservableObject {
    var subscriptions = Set<AnyCancellable>()
    
    @Inject private var workspaceRepo: WorkspaceRepo
    @Inject private var chatRepo: ChatRepo
    
    @Published var selection = segmentedButtonRoles[0]
    @Published var members: Flow<[RetrieveProfile]> = .fetching
    @Published var searchText: String = ""
    @Published var isSearching: Bool = false
    
    @Published var createRoomFlow: Flow<String> = .idle
    @Published var createdRoom: Flow<Room> = .idle
}

extension WorkspaceMemberViewModel {
    var selectedMembers: Flow<[RetrieveProfile]> {
        return members.map {
            $0.filter {
                // 선생님을 선택했을 경우
                if selection == segmentedButtonRoles[0] {
                    $0.permission != .student
                } else {
                    $0.permission == .student
                }
            }
        }
    }
    
    var searchedMembers: Flow<[RetrieveProfile]> {
        selectedMembers.map { $0.search(text: searchText) }
    }
    
    var mergedMembers: Flow<[RetrieveProfile]> {
        self.isSearching ? self.searchedMembers : self.selectedMembers
    }
}

extension WorkspaceMemberViewModel {
    func fetchMembers(workspaceId: String) {
        workspaceRepo.getMembers(workspaceId: workspaceId)
            .map(\.data)
            .map { $0.sorted { $0.permission > $1.permission } }
            .flow(\.members, on: self)
            .silentSink()
            .store(in: &subscriptions)
    }
    
    func createPersonalChat(
        workspaceId: String,
        memberId: Int,
        anotherMemberId: Int
    ) {
        self.createRoomFlow = .fetching
        chatRepo.createPersonal(
            .init(
                roomName: "",
                workspaceId: workspaceId,
                joinUsers: [memberId, anotherMemberId],
                chatRoomImg: ""
            )
        )
        .map(\.data)
        .flow(\.createRoomFlow, on: self)
        .ignoreError()
        .sink(receiveValue: self.fetchCreatedPersonalRoom)
        .store(in: &subscriptions)
    }
    
    private func fetchCreatedPersonalRoom(roomId: String) {
        chatRepo.searchPersonal(roomId: roomId)
            .map(\.data)
            .flow(\.createdRoom, on: self)
            .silentSink()
            .store(in: &subscriptions)
    }
}
