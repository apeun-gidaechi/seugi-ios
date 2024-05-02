import Swinject
import AuthDomainInterface

public class AuthDomainAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        
        // MARK: - DataSource
        container.register(AuthDataSource.self) { _ in
            AuthDataSourceImpl()
        }.inObjectScope(.container)
        container.register(OAuthDataSource.self) { _ in
            OAuthDataSourceImpl()
        }.inObjectScope(.container)
        
        // MARK: - Repository
        container.register(AuthRepository.self) {
            AuthRepositoryImpl(
                authDataSource: $0.resolve(AuthDataSource.self)!,
                oauthDataSource: $0.resolve(OAuthDataSource.self)!
            )
        }.inObjectScope(.container)
        
        // MARK: - UseCase
        container.register(SignInUseCase.self) {
            SignInUseCaseImpl(authRepository: $0.resolve(AuthRepository.self)!)
        }.inObjectScope(.container)
        container.register(SignUpUseCase.self) {
            SignUpUseCaseImpl(authRepository: $0.resolve(AuthRepository.self)!)
        }.inObjectScope(.container)
        container.register(SendEmailCodeUseCase.self) {
            SendEmailCodeUseCaseImpl(authRepository: $0.resolve(AuthRepository.self)!)
        }.inObjectScope(.container)
        container.register(VerifyEmailCodeUseCase.self) {
            VerifyEmailCodeUseCaseImpl(authRepository: $0.resolve(AuthRepository.self)!)
        }.inObjectScope(.container)
        container.register(OAuthSignInUseCase.self) {
            OAuthSignInUseCaseImpl(authRepository: $0.resolve(AuthRepository.self)!)
        }.inObjectScope(.container)
    }
}
