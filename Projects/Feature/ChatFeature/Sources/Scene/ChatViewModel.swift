import Foundation
import Domain
import BaseFeatureInterface
import DIContainer

public final class ChatViewModel: ObservableObject {
    
    // MARK: - UseCases
//    @Inject private var getPersonalChatUseCase: any GetPersonalChatUseCase
    
    // MARK: - States
//    @Published var chats: FetchFlow<[Chat]> = .fetching
    
    public init() {}
    
    @MainActor
    func fetchChats(workspaceId: String) async {
        do {
//            let chats = try await getPersonalChatUseCase(workspaceId: workspaceId)
//            self.chats = .success(chats)
        } catch {
            print(error)
//            chats = .failure
        }
    }
}
