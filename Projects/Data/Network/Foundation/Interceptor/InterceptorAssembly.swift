import Swinject
import Domain

public final class InterceptorAssembly: Assembly {
    public init() {}
    
    public func assemble(container: Container) {
        container.register(AuthInterceptor.self) {
            AuthInterceptor(
                keyValueStore: $0.resolve(KeyValueRepo.self)!,
                keychainRepo: $0.resolve(KeychainRepo.self)!
            )
        }
    }
}
