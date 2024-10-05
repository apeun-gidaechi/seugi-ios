import Swinject
import Moya

#if LOG
private let plugins = [
    NetworkLoggerPlugin(
        configuration: .init(
            logOptions: [
                .requestMethod,
                .requestBody,
                .successResponseBody,
                .errorResponseBody
            ]
        )
    )
]
#else
private let plugins: [PluginType] = []
#endif

public final class NetRunnerAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(MoyaProvider<AnyEndpoint>.self, name: "none") { _ in
            MoyaProvider(session: Session(), plugins: plugins)
        }
        
        container.register(MoyaProvider<AnyEndpoint>.self, name: "authorization") {
            MoyaProvider(session: Session(interceptor: $0.resolve(AuthInterceptor.self)!), plugins: plugins)
        }
        
        container.register(NetRunner.self) {
            DefaultNetRunner(
                provider: $0.resolve(MoyaProvider<AnyEndpoint>.self, name: "none")!,
                authProvider: $0.resolve(MoyaProvider<AnyEndpoint>.self, name: "authorization")!,
                decoder: .myDecoder
            )
        }
    }
}
