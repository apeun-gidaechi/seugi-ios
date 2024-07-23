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
    @Inject private var profileRepo: ProfileRepo
    
    // MARK: - State
    @Published public var selectedMainTab = SeugiBottomNavigationType.home
    
    /* workspace */
    @Published public var workspaces: FetchFlow<[Workspace]> = .fetching
    @Published public var selectedWorkspace: Workspace?
    public var workspaceRole: WorkspaceRole? {
        guard let selectedWorkspace,
              let memberId = profile.data?.member.id
        else {
            return nil
        }
        return if selectedWorkspace.student.contains(memberId) {
            .student
        } else if selectedWorkspace.teacher.contains(memberId) {
            .teacher
        } else if selectedWorkspace.middleAdmin.contains(memberId) {
            .middleAdmin
        } else if selectedWorkspace.workspaceAdmin == memberId {
            .admin
        } else {
            nil
        }
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
    
    public func clearToken() {
        accessToken = ""
        refreshToken = ""
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
            withAnimation(.spring(duration: 0.4)) {
                self.workspaces = .success(workspaces.data)
                if let workspace = workspaces.data.first,
                   selectedWorkspace == nil {
                    selectedWorkspace = workspace
                }
            }
        } failure: { [self] error in
            print("💎 AppState.fetchWorkspaces - \(error)")
            if case .refreshFailure = error {
                clearToken()
            }
            withAnimation(.spring(duration: 0.4)) {
                workspaces = .failure(error)
            }
        } finished: { [self] in
            print("💎 workspace fetched")
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
