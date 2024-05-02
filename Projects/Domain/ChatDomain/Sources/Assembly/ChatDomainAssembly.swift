import Swinject
import ChatDomainInterface

public struct ChatDomainAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(ChatRepository.self) {
            ChatRepositoryImpl(groupChatDataSource: $0.resolve(GroupChatDataSource.self)!, personalChatDataSource: $0.resolve(PersonalChatDataSource.self)!)
        }.inObjectScope(.container)
        container.register(GroupChatDataSource.self) { _ in
            GroupChatDataSourceImpl()
        }.inObjectScope(.container)
        container.register(PersonalChatDataSource.self) { _ in
            PersonalChatDataSourceImpl()
        }.inObjectScope(.container)
    }
}
