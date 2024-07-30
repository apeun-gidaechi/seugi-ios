import Foundation
import Domain
import BaseFeatureInterface
import DIContainer

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
    public var searchedPersonalRooms: [Room] {
        if personalSearchText.isEmpty {
            personalRooms.data ?? []
        } else {
            personalRooms.data?.filter { room in
                room.chatName.contains(personalSearchText)
            } ?? []
        }
    }
    
    /* group */
    @Published public var groupRooms: FetchFlow<[Room]> = .fetching
    @Published public var groupSearchText = ""
    public var searchedGroupRooms: [Room] {
        if groupSearchText.isEmpty {
            groupRooms.data ?? []
        } else {
            groupRooms.data?.filter { room in
                room.chatName.contains(groupSearchText)
            } ?? []
        }
    }
    
    // MARK: - Method
    public func fetchChats(workspaceId: String) {
        sub(chatRepo.searchPersonal(workspaceId: workspaceId)) {
            self.personalRooms = .fetching
        } success: { res in
            self.personalRooms = .success(res.data)
        } failure: { error in
            debugPrint(error)
            self.personalRooms = .failure(error)
            self.emit(.refreshFailure)
        }
        sub(chatRepo.searchGroup(workspaceId: workspaceId)) {
            self.groupRooms = .fetching
        } success: { res in
            self.groupRooms = .success(res.data)
        } failure: { error in
            debugPrint(error)
            self.groupRooms = .failure(error)
            self.emit(.refreshFailure)
        }
    }
    
    public func clearSearchText() {
        personalSearchText = ""
        groupSearchText = ""
    }
}
