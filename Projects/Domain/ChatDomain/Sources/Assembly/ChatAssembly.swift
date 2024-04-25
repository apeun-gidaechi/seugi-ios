import Swinject
import ChatDomainInterface

struct ChatAssembly: Assembly {
    func assemble(container: Container) {
        container.register(ChatRepository.self) {
            ChatRepositoryImpl(groupChatDataSource: $0.resolve(GroupChatDataSource.self)!)
        }
        container.register(GroupChatDataSource.self) { _ in
            GroupChatDataSourceImpl()
        }.inObjectScope(.container)
        container.register(PersonalChatDataSource.self) { _ in
            PersonalChatDataSourceImpl()
        }.inObjectScope(.container)
    }
}
