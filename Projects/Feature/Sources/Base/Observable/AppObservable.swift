import Foundation
import Domain
import DIContainer
import SwiftUI
import Component

@propertyWrapper
struct AppState: DynamicProperty {
    @EnvironmentObject private var appState: AppObservable
    
    var wrappedValue: AppObservable {
        appState
    }
}

public final class AppObservable: BaseViewModel<AppObservable.Effect> {
    
    public enum Effect {
        case workspaceFetched
        case logout
    }
    
    // MARK: - Repo
    @Inject private var keyValueRepo: KeyValueRepo
    @Inject private var keychainRepo: KeychainRepo
    @Inject private var workspaceRepo: WorkspaceRepo
    @Inject private var profileRepo: ProfileRepo
    
    // MARK: - State
    @Published public var selectedMainTab = SeugiBottomNavigationType.home
    
    /* workspace */
    @Published public var workspaces: FetchFlow<[Workspace]> = .fetching
    @Published public var selectedWorkspace: Workspace? {
        didSet {
            if let workspaceId = selectedWorkspace?.workspaceId {
                keyValueRepo.save(key: .selectedWorkspaceId, value: workspaceId)
            }
        }
    }
    public var workspaceRole: WorkspaceRole? {
        guard let selectedWorkspace,
              let memberId = profile.data?.member.id else {
            return nil
        }
        return .getRole(memberId: memberId, workspace: selectedWorkspace)
    }
    
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
    
    /* my info */
    @Published public var profile: FetchFlow<RetrieveProfile> = .fetching
    
    // MARK: - Method
    public override init() {
        super.init()
        accessToken = keyValueRepo.load(key: .accessToken) ?? ""
        refreshToken = keychainRepo.load(key: .refreshToken) ?? ""
        $accessToken
            .sink {
                self.keyValueRepo.save(key: .accessToken, value: $0)
            }
            .store(in: &subscriptions)
        $refreshToken
            .sink {
                self.keychainRepo.save(key: .refreshToken, value: $0)
            }
            .store(in: &subscriptions)
    }
    
    public func login() {
        fetchWorkspaces()
    }
    
    public func logout() {
        selectedMainTab = .home
        accessToken = ""
        refreshToken = ""
        selectedWorkspace = nil
        profile = .fetching
        emit(.logout)
    }
    
    public func fetchWorkspaces() {
        log("💎 try to fetch workspace")
        guard !accessToken.isEmpty else {
            emit(.workspaceFetched)
            return
        }
        sub(workspaceRepo.getWorkspaces()) {
            self.workspaces = .fetching
        } success: { [self] workspaces in
            withAnimation(.spring(duration: 0.4)) {
                self.workspaces = .success(workspaces.data)
                if let selectedWorkspaceId = (keyValueRepo.load(key: .selectedWorkspaceId) as? String),
                   let selectedWorkspace = workspaces.data.first(where: { $0.workspaceId == selectedWorkspaceId }) {
                    self.selectedWorkspace = selectedWorkspace
                } else if let workspace = workspaces.data.first,
                          selectedWorkspace == nil {
                    selectedWorkspace = workspace
                }
            }
        } failure: { [self] error in
            log("💎 AppState.fetchWorkspaces - \(error)")
            if case .refreshFailure = error {
                logout()
            }
            withAnimation(.spring(duration: 0.4)) {
                workspaces = .failure(error)
            }
        } finished: { [self] in
            log("💎 workspace fetched")
            emit(.workspaceFetched)
        }
    }
    
    public func fetchMyInfo() {
        guard let selectedWorkspace else {
            return
        }
        sub(profileRepo.me(workspaceId: selectedWorkspace.workspaceId)) {
            self.profile = .fetching
        } success: { profile in
            self.profile = .success(profile.data)
        } failure: { error in
            self.profile = .failure(error)
        }
    }
}
