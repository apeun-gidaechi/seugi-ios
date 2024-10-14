import Combine
import Foundation
import Domain
import DIContainer
import SwiftUtil

public final class ChatViewModel: ObservableObject {
    var subscriptions = Set<AnyCancellable>()
    
    @Inject private var chatRepo: ChatRepo
    
    @Published var personalRooms: Flow<[Room]> = .fetching
    @Published var groupRooms: Flow<[Room]> = .fetching
    @Published var searchText = ""
    @Published var isSearching = false
    
    private let roomType: RoomType
    
    init(roomType: RoomType) {
        self.roomType = roomType
    }
}

extension ChatViewModel {
    private var rooms: Flow<[Room]> {
        switch roomType {
        case .personal: personalRooms
        case .group: groupRooms
        }
    }
    
    private var sortedRooms: Flow<[Room]> {
        rooms.map { $0.sorted { $0.lastMessageTimestamp > $1.lastMessageTimestamp } }
    }
    
    private var searchRooms: Flow<[Room]> {
        sortedRooms.map { $0.search(text: searchText) }
    }
    
    var mergedRooms: Flow<[Room]> {
        if isSearching {
            searchRooms
        } else {
            sortedRooms
        }
    }
}

extension ChatViewModel {
    func fetchChats(
        workspaceId: String,
        roomType: RoomType
    ) {
        switch roomType {
        case .personal:
            chatRepo.searchPersonal(workspaceId: workspaceId)
                .map(\.data)
                .flow(\.personalRooms, on: self)
                .silentSink()
                .store(in: &subscriptions)
        case .group:
            chatRepo.searchGroup(workspaceId: workspaceId)
                .map(\.data)
                .flow(\.groupRooms, on: self)
                .silentSink()
                .store(in: &subscriptions)
        }
    }
}
