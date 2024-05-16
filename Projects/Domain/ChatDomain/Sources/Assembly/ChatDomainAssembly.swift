import Swinject
import ChatDomainInterface

public struct ChatDomainAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        
        // MARK: - UseCase
        container.register(AddJoinedUseCase.self) {
            AddJoinedUseCaseImpl(chatRepository: $0.resolve(ChatRepository.self)!)
        }
        container.register(CreateGroupChatUseCase.self) {
            CreateGroupChatUseCaseImpl(chatRepository: $0.resolve(ChatRepository.self)!)
        }
        container.register(CreatePersonalChatUseCase.self) {
            CreatePersonalChatUseCaseImpl(chatRepository: $0.resolve(ChatRepository.self)!)
        }
        container.register(GetGroupChatUseCase.self) {
            GetGroupChatUseCaseImpl(chatRepository: $0.resolve(ChatRepository.self)!)
        }
        container.register(GetJoinedUseCase.self) {
            GetJoinedUseCaseImpl(chatRepository: $0.resolve(ChatRepository.self)!)
        }
        container.register(OutJoinedUseCase.self) {
            OutJoinedUseCaseImpl(chatRepository: $0.resolve(ChatRepository.self)!)
        }
        container.register(SearchPersonalChatUseCase.self) {
            SearchPersonalChatUseCaseImpl(chatRepository: $0.resolve(ChatRepository.self)!)
        }
        
        // MARK: - Repository
        container.register(ChatRepository.self) {
            ChatRepositoryImpl(groupChatDataSource: $0.resolve(GroupChatDataSource.self)!, personalChatDataSource: $0.resolve(PersonalChatDataSource.self)!)
        }.inObjectScope(.container)
        
        // MARK: - DataSource
        container.register(GroupChatDataSource.self) { _ in
            GroupChatDataSourceImpl()
        }.inObjectScope(.container)
        container.register(PersonalChatDataSource.self) { _ in
            PersonalChatDataSourceImpl()
        }.inObjectScope(.container)
    }
}
