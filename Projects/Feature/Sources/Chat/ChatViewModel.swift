import Foundation
import Domain
import DIContainer
import SwiftUtil

public final class ChatViewModel: BaseViewModel<ChatViewModel.Effect> {
    
    public enum Effect {
        case refreshFailure
    }
    
    // MARK: - Repo
    @Inject private var chatRepo: ChatRepo
    
    // MARK: - State
    /* personal */
    @Published var personalRooms: FetchFlow<[Room]> = .fetching
    @Published var groupRooms: FetchFlow<[Room]> = .fetching
    @Published var searchText = ""
    @Published var isSearching = false
    
    var roomType: RoomType?
    
    private var rooms: FetchFlow<[Room]> {
        guard let roomType else { return .fetching }
        return switch roomType {
        case .personal: personalRooms
        case .group: groupRooms
        }
    }
    
    private var sortedRooms: FetchFlow<[Room]> {
        rooms.map {
            $0.sorted { $0.lastMessageTimestamp > $1.lastMessageTimestamp }
        }
    }
    
    private var searchRooms: FetchFlow<[Room]> {
        guard roomType != nil else { return .fetching }
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
    
    var mergedRooms: FetchFlow<[Room]> {
        isSearching ? searchRooms : sortedRooms
    }
    
    // MARK: - Method
    func fetchChats(workspaceId: String) {
        chatRepo.searchPersonal(workspaceId: workspaceId).fetching {
            self.personalRooms = .fetching
        }.success { res in
            self.personalRooms = .success(res.data)
        }.failure { error in
            log(error)
            self.personalRooms = .failure(error)
            self.emit(.refreshFailure)
        }.observe(&subscriptions)
        
        chatRepo.searchGroup(workspaceId: workspaceId).fetching {
            self.groupRooms = .fetching
        }.success { res in
            self.groupRooms = .success(res.data)
        }.failure { error in
            log(error)
            self.groupRooms = .failure(error)
            self.emit(.refreshFailure)
        }.observe(&subscriptions)
    }
}
