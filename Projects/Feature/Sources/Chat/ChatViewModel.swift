import Foundation
import Domain
import DIContainer
import SwiftUtil

public final class ChatViewModel: BaseViewModel<ChatViewModel.ChatSubject> {
    
    public enum ChatSubject {
        case refreshFailure
    }
    
    // MARK: - Repo
    @Inject private var chatRepo: ChatRepo
    
    // MARK: - State
    /* personal */
    @Published public var personalRooms: FetchFlow<[Room]> = .fetching
    @Published public var personalSearchText = ""
    public var searchedPersonalRooms: FetchFlow<[Room]> {
        guard !personalSearchText.isEmpty else {
            return personalRooms
        }
        guard let rooms = personalRooms.data?.filter({ room in
            room.chatName.contains(personalSearchText)
        }) else {
            return .fetching
        }
        return .success(rooms)
    }
    
    /* group */
    @Published public var groupRooms: FetchFlow<[Room]> = .fetching
    @Published public var groupSearchText = ""
    public var searchedGroupRooms: FetchFlow<[Room]> {
        guard !groupSearchText.isEmpty else {
            return groupRooms
        }
        guard let rooms = groupRooms.data?.filter({ room in
            room.chatName.contains(groupSearchText)
        }) else {
            return .fetching
        }
        return .success(rooms)
    }
    
    // MARK: - Method
    public func fetchChats(workspaceId: String) {
        sub(chatRepo.searchPersonal(workspaceId: workspaceId)) {
            self.personalRooms = .fetching
        } success: { res in
            self.personalRooms = .success(res.data)
        } failure: { error in
            log(error)
            self.personalRooms = .failure(error)
            self.emit(.refreshFailure)
        }
        sub(chatRepo.searchGroup(workspaceId: workspaceId)) {
            self.groupRooms = .fetching
        } success: { res in
            self.groupRooms = .success(res.data)
        } failure: { error in
            log(error)
            self.groupRooms = .failure(error)
            self.emit(.refreshFailure)
        }
    }
    
    public func clearSearchText() {
        personalSearchText = ""
        groupSearchText = ""
    }
}
