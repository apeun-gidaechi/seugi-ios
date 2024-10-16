import Combine
import Foundation
import DIContainer
import Domain
import SwiftUtil

final class MainViewModel: ObservableObject {
    var subscriptions = Set<AnyCancellable>()
    
    @Inject private var workspaceRepo: WorkspaceRepo
    @Inject private var profileRepo: ProfileRepo
    @Inject private var keyValueRepo: KeyValueRepo
    
    @Published var workspaces: Flow<[Workspace]> = .fetching
    @Published var selectedWorkspace: Workspace?
    @Published var profile: Flow<RetrieveProfile> = .fetching
    
    var workspaceRole: WorkspaceRole? {
        guard let selectedWorkspace,
              let member = profile.data?.member else {
            return nil
        }
        return .getRole(memberId: member.id, workspace: selectedWorkspace)
    }
    
    init() {
        self.fetchWorkspaces()
        self.observeState()
    }
}

extension MainViewModel {
    private func observeState() {
        $selectedWorkspace.sink {
            guard let id = $0?.workspaceId else { return }
            self.keyValueRepo.save(key: .selectedWorkspaceId, value: id)
        }
        .store(in: &subscriptions)
    }
    
    public func fetchWorkspaces() {
        workspaceRepo.getWorkspaces()
            .map(\.data)
            .flow(\.workspaces, on: self)
            .sink { [self] in
                if case .failure(let error) = $0 {
                    Log.error("AppState.fetchWorkspaces - \(error)")
//                    if case .refreshFailure = error {
//                        logout()
//                    }
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
