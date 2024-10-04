import Foundation
import Domain
import DIContainer
import SwiftUtil
import Combine

public final class ChatViewModel: ObservableObject {
    
    // MARK: - Repo
    @Inject private var chatRepo: ChatRepo
    
    // MARK: - State
    /* personal */
    @Published var personalRooms: Flow<[Room]> = .fetching
    @Published var groupRooms: Flow<[Room]> = .fetching
    @Published var searchText = ""
    @Published var isSearching = false
    
    private let roomType: RoomType
    var subscriptions = Set<AnyCancellable>()
    
    init(roomType: RoomType) {
        self.roomType = roomType
    }
    
    private var rooms: Flow<[Room]> {
        switch roomType {
        case .personal: personalRooms
        case .group: groupRooms
        }
    }
    
    private var sortedRooms: Flow<[Room]> {
        rooms.map {
            $0.sorted { $0.lastMessageTimestamp > $1.lastMessageTimestamp }
        }
    }
    
    private var searchRooms: Flow<[Room]> {
        guard !searchText.isEmpty else {
            return sortedRooms
        }
        guard let rooms = sortedRooms.data?.filter({ room in
            room.chatName.contains(searchText)
        }) else {
            return .fetching
        }
        return .success(rooms)
    }
    
    var mergedRooms: Flow<[Room]> {
        isSearching ? searchRooms : sortedRooms
    }
    
    func fetchChats(workspaceId: String) {
        switch roomType {
        case .personal:
            chatRepo.searchPersonal(workspaceId: workspaceId)
                .map(\.data)
                .flow(\.personalRooms, on: self)
                .silentSink()
                .store(in: &subscriptions)
            
            // TODO: Handle refreshFailure
//            
//            if case .refreshFailure = error {
//                self.emit(.refreshFailure)
//            }
        case .group:
            chatRepo.searchGroup(workspaceId: workspaceId)
                .map(\.data)
                .flow(\.groupRooms, on: self)
                .silentSink()
                .store(in: &subscriptions)
        }
    }
}
