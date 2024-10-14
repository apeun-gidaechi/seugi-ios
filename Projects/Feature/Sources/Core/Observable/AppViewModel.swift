import Foundation
import SwiftUI
import Combine

import DIContainer
import Domain
import SwiftUtil

public final class AppViewModel: ObservableObject {
    var subscriptions = Set<AnyCancellable>()
    
    @Inject private var keyValueRepo: KeyValueRepo
    @Inject private var keychainRepo: KeychainRepo
    @Inject private var workspaceRepo: WorkspaceRepo
    @Inject private var profileRepo: ProfileRepo
    @Inject private var memberRepo: MemberRepo
    
    @AppStorage("accessToken", store: .seugi) var accessToken: String?
    @AppStorage("refreshToken", store: .seugi) var refreshToken: String?
    @Published var workspaces: Flow<[Workspace]> = .fetching
    @Published var selectedWorkspace: Workspace?
    @Published var profile: Flow<RetrieveProfile> = .fetching
    @Published var logoutFlow: Flow<BaseVoid> = .idle
    
    public init() {
        fetchWorkspaces()
        observeState()
    }
}

public extension AppViewModel {
    var workspaceRole: WorkspaceRole? {
        guard let selectedWorkspace,
              let member = profile.data?.member else {
            return nil
        }
        return .getRole(memberId: member.id, workspace: selectedWorkspace)
    }
}

extension AppViewModel {
    private func observeState() {
        $selectedWorkspace.sink {
            guard let id = $0?.workspaceId else { return }
            self.keyValueRepo.save(key: .selectedWorkspaceId, value: id)
        }.store(in: &subscriptions)
    }
    
    public func login() {
        fetchWorkspaces()
    }
    
    public func logout() {
        if let fcmToken = keyValueRepo.load(key: .fcmToken) as? String {
            memberRepo.logout(
                .init(fcmToken: fcmToken)
            )
            .flow(\.logoutFlow, on: self)
            .silentSink()
            .store(in: &subscriptions)
        }
        accessToken = nil
        refreshToken = nil
        selectedWorkspace = nil
        profile = .idle
        workspaces = .idle
    }
    
    public func fetchWorkspaces() {
        workspaceRepo.getWorkspaces()
            .map(\.data)
            .flow(\.workspaces, on: self)
            .sink { [self] in
                if case .failure(let error) = $0 {
                    Log.error("AppState.fetchWorkspaces - \(error)")
                    if case .refreshFailure = error {
                        logout()
                    }
                }
            } receiveValue: { [self] workspaces in
                if let id: String = keyValueRepo.load(key: .selectedWorkspaceId),
                   let selectedWorkspace = workspaces.first(where: { $0.workspaceId == id }) {
                    // 선택한 workspace가 있었다면
                    self.selectedWorkspace = selectedWorkspace
                } else if let workspace = workspaces.first {
                    // 아니면 첫 번째 workspace
                    self.selectedWorkspace = workspace
                }
                fetchMyInfo()
            }
            .store(in: &subscriptions)
    }
    
    public func fetchMyInfo() {
        guard let selectedWorkspace else { return }
        profileRepo.me(workspaceId: selectedWorkspace.workspaceId)
            .map(\.data)
            .flow(\.profile, on: self)
            .silentSink()
            .store(in: &subscriptions)
    }
}
