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
        case logout
    }
    
    // MARK: - Repo
    @Inject private var keyValueRepo: KeyValueRepo
    @Inject private var keychainRepo: KeychainRepo
    @Inject private var workspaceRepo: WorkspaceRepo
    @Inject private var profileRepo: ProfileRepo
    
    // MARK: - State
    // workspace
    @Published public var workspaces: FetchFlow<[Workspace]> = .fetching
    @Published public var selectedWorkspace: Workspace?
    public var workspaceRole: WorkspaceRole? {
        guard let selectedWorkspace,
              let memberId = profile.data?.member.id else {
            return nil
        }
        return .getRole(memberId: memberId, workspace: selectedWorkspace)
    }
    
    // token
    @Published public var accessToken: String?
    @Published public var refreshToken: String?
    
    @Published public var profile: FetchFlow<RetrieveProfile> = .fetching
    
    // MARK: - Method
    public override init() {
        super.init()
        accessToken = keyValueRepo.load(key: .accessToken)
        refreshToken = keychainRepo.load(key: .refreshToken)
        observeState()
    }
    
    private func observeState() {
        $accessToken.sink {
            if let token = $0 {
                self.keyValueRepo.save(key: .accessToken, value: token)
            } else {
                self.keyValueRepo.delete(key: .accessToken)
            }
        }.store(in: &subscriptions)
        
        $refreshToken.sink {
            if let token = $0 {
                self.keychainRepo.save(key: .refreshToken, value: token)
            } else {
                self.keychainRepo.delete(key: .refreshToken)
            }
        }.store(in: &subscriptions)
        
        $selectedWorkspace.sink { _ in
            if let id = self.selectedWorkspace?.workspaceId {
                self.keyValueRepo.save(key: .selectedWorkspaceId, value: id)
                self.fetchWorkspaces()
            }
        }.store(in: &subscriptions)
    }
    
    public func login() {
        fetchWorkspaces()
    }
    
    public func logout() {
        accessToken = ""
        refreshToken = ""
        selectedWorkspace = nil
        profile = .fetching
        emit(.logout)
    }
    
    public func fetchWorkspaces() {
        guard accessToken != nil else { return }
        workspaceRepo.getWorkspaces().fetching {
            self.workspaces = .fetching
        }.success { [self] workspaces in
            self.workspaces = .success(workspaces.data)
            if let id: String = keyValueRepo.load(key: .selectedWorkspaceId),
               let selectedWorkspace = workspaces.data.first(where: { $0.workspaceId == id }) {
                // 선택한 workspace가 있었다면
                self.selectedWorkspace = selectedWorkspace
            } else if let workspace = workspaces.data.first {
                // 아니면 첫 번째 workspace
                selectedWorkspace = workspace
            }
            fetchMyInfo()
        }.failure { [self] error in
            log("💎 AppState.fetchWorkspaces - \(error)")
            if case .refreshFailure = error {
                logout()
            }
            workspaces = .failure(error)
        }.observe(&subscriptions)
    }
    
    public func fetchMyInfo() {
        guard let selectedWorkspace else { return }
        profileRepo.me(workspaceId: selectedWorkspace.workspaceId).fetching {
            self.profile = .fetching
        }.success { profile in
            self.profile = .success(profile.data)
        }.failure { error in
            self.profile = .failure(error)
        }.observe(&subscriptions)
    }
}
