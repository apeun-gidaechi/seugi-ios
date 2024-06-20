import Foundation
import Component
import Domain
import DIContainer
import SwiftUI

public final class AppState: BaseViewModel<AppState.AppSubject> {
    
    public enum AppSubject {
        case fetchWorkspaceSuccess
    }
    
    // MARK: - Repo
    @Inject private var keyValueRepo: KeyValueRepo
    @Inject private var workspaceRepo: WorkspaceRepo
    
    // MARK: - State
    @Published public var isAppFlowFetching = true
    @Published public var appFlow: AppFlow = .unAuthorized
    @Published public var mainFlow: SeugiBottomNavigationData = .init(
        cellData: [
            .init(type: .home, hasBadge: false),
            .init(type: .chat, hasBadge: false),
            .init(type: .room, hasBadge: false),
            .init(type: .notification, hasBadge: false),
            .init(type: .profile, hasBadge: false)
        ],
        selectedTab: .home
    )
    
    /* workspace */
    @Published public var workspaces: FetchFlow<[Workspace]> = .fetching
    @Published public var selectedWorkspace: Workspace?
    
    /* token */
    @Published public var accessToken: String = ""
    @Published public var refreshToken: String = ""
    public var token: Token {
        get {
            Token(accessToken: accessToken, refreshToken: refreshToken)
        }
        set {
            accessToken = newValue.accessToken
            refreshToken = newValue.refreshToken
        }
    }
    
    public override init() {
        super.init()
        self.mainFlow = mainFlow
        accessToken = keyValueRepo.load(key: .accessToken) ?? ""
        refreshToken = keyValueRepo.load(key: .refreshToken) ?? ""
        $accessToken
            .sink {
                self.keyValueRepo.save(key: .accessToken, value: $0)
            }
            .store(in: &subscriptions)
        $refreshToken
            .sink {
                self.keyValueRepo.save(key: .refreshToken, value: $0)
            }
            .store(in: &subscriptions)
    }
    
    public func fetchWorkspaces() {
        guard !accessToken.isEmpty else {
            withAnimation {
                appFlow = .unAuthorized // - unAuthorized
            }
            sleep(2)
            emit(.fetchWorkspaceSuccess)
            return
        }
        sub(workspaceRepo.getWorkspaces()) {
            self.isAppFlowFetching = true
            self.workspaces = .fetching
        } success: { [self] workspaces in
            self.workspaces = .success(workspaces.data)
            if let workspace = workspaces.data.first,
               selectedWorkspace == nil {
                selectedWorkspace = workspace
            }
            withAnimation {
                appFlow = .authorized // - authorized
            }
        } failure: { [self] error in
            print(error)
            withAnimation {
                if case .http(let error) = error {
                    if error.status == 401 {
                        appFlow = .unAuthorized // - unAuthorized
                    }
                } else {
                    appFlow = .notFoundJoinedSchool // - notFoundJoinedSchool
                    workspaces = .failure(error)
                }
            }
        } finished: { [self] in
            isAppFlowFetching = false
            emit(.fetchWorkspaceSuccess)
        }
    }
}
