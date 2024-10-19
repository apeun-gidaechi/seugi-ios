import Foundation
import Domain
import DIContainer
import SwiftUtil
import Combine

final class WorkspaceMemberViewModel: ObservableObject {
    var subscriptions = Set<AnyCancellable>()
    
    @Inject private var workspaceRepo: WorkspaceRepo
    
    @Published var selection = segmentedButtonRoles[0]
    @Published var members: Flow<[RetrieveProfile]> = .fetching
    @Published var searchText: String = ""
    @Published var isSearching: Bool = false
}

extension WorkspaceMemberViewModel {
    var selectedMembers: Flow<[RetrieveProfile]> {
        return members.map {
            $0.filter {
                // 선생님을 선택했을 경우
                if selection == segmentedButtonRoles[0] {
                    $0.permission != .student
                } else {
                    $0.permission == .student
                }
            }
        }
    }
    
    var searchedMembers: Flow<[RetrieveProfile]> {
        selectedMembers.map { $0.search(text: searchText) }
    }
    
    var mergedMembers: Flow<[RetrieveProfile]> {
        self.isSearching ? self.searchedMembers : self.selectedMembers
    }
}

extension WorkspaceMemberViewModel {
    func fetchMembers(workspaceId: String) {
        workspaceRepo.getMembers(workspaceId: workspaceId)
            .map(\.data)
            .flow(\.members, on: self)
            .silentSink()
            .store(in: &subscriptions)
    }
}
