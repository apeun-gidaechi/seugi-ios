import Foundation
import Domain
import BaseFeatureInterface
import DIContainer

public final class ChatViewModel: BaseViewModel<ChatViewModel.ChatSubject> {
    
    public enum ChatSubject {}
    
    // MARK: - Repo
    @Inject private var chatRepo: ChatRepo
    
    // MARK: - State
    @Published public var personalRooms: FetchFlow<[Room]> = .fetching
    @Published public var groupRooms: FetchFlow<[Room]> = .fetching
    
    // MARK: - Method
    public func fetchChats(workspaceId: String) {
        sub(chatRepo.searchPersonal(workspaceId: workspaceId)) {
            self.personalRooms = .fetching
        } success: { res in
            self.personalRooms = .success(res.data)
        } failure: { error in
            self.personalRooms = .failure(error)
        }
        sub(chatRepo.searchGroup(workspaceId: workspaceId)) {
            self.groupRooms = .fetching
        } success: { res in
            self.groupRooms = .success(res.data)
        } failure: { error in
            self.groupRooms = .failure(error)
        }
    }
}
