import Foundation
import Component
import Domain
import DIContainer
import SwiftUI

public final class AppState: BaseViewModel<AppState.AppSubject> {
    
    public enum AppSubject {
        case workspaceFetched
    }
    
    // MARK: - Repo
    @Inject private var keyValueRepo: KeyValueRepo
    @Inject private var workspaceRepo: WorkspaceRepo
    
    // MARK: - State
    @Published public var selectedMainTab = SeugiBottomNavigationType.home
    
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
    
    public func clearToken() {
        accessToken = ""
        refreshToken = ""
    }
    
    public override init() {
        super.init()
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
        print("💎 try to fetch workspace")
        guard !accessToken.isEmpty else {
            emit(.workspaceFetched)
            return
        }
        sub(workspaceRepo.getWorkspaces()) {
            self.workspaces = .fetching
        } success: { [self] workspaces in
            withAnimation {
                self.workspaces = .success(workspaces.data)
                if let workspace = workspaces.data.first,
                   selectedWorkspace == nil {
                    selectedWorkspace = workspace
                }
            }
        } failure: { [self] error in
            print("failruererqer")
            print(error)
            if case .refreshFailure = error {
                accessToken = ""
                refreshToken = ""
            } else if case .http(let res) = error,
                      res.state == "FORBIDDEN" {
                accessToken = ""
                refreshToken = ""
            }
            withAnimation {
                workspaces = .failure(error)
            }
        } finished: { [self] in
            print("💎 workspace fetched")
            emit(.workspaceFetched)
        }
    }
}
