import Foundation
import DesignSystem
import WorkspaceDomainInterface
import DIContainerInterface
import UserDefaultInterface

public final class AppState: ObservableObject {
    
    // MARK: - UseCase
    @Inject private var getWorkspacesUseCase: GetWorkspacesUseCase
    @Inject private var keyValueStore: any KeyValueStore
    
    // MARK: - State
    @Published public var appFlow: AppFlow = .unAuthorized
    @Published public var mainFlow: SeugiBottomNavigationData
    @Published public var workspaces: FetchFlow<[Workspace]> = .fetching
    @Published private(set) var accessToken = ""
    @Published private(set) var refreshToken = ""
    
    public init(
        mainFlow: SeugiBottomNavigationData
    ) {
        self.mainFlow = mainFlow
        accessToken = keyValueStore.load(key: .accessToken) ?? ""
        refreshToken = keyValueStore.load(key: .refreshToken) ?? ""
        appFlow = accessToken.isEmpty ? .unAuthorized : .authorized
    }
    
    public func setAccessToken(with token: String) {
        keyValueStore.save(key: .accessToken, value: token)
        accessToken = token
    }
    
    public func setRefreshToken(with token: String) {
        keyValueStore.save(key: .refreshToken, value: token)
        refreshToken = token
    }
    
    @MainActor
    public func fetchWorkspaces() async {
        guard !accessToken.isEmpty else { return }
        do {
            self.workspaces = .fetching
            let workspaces = try await getWorkspacesUseCase()
            self.workspaces = .success(data: workspaces)
        } catch {
            self.appFlow = .notFoundJoinedSchool
            self.workspaces = .failure
        }
    }
}
