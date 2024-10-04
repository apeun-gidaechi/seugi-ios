import Foundation
import Domain
import DIContainer
import SwiftUtil

final class WorkspaceMemberViewModel: BaseViewModel<WorkspaceMemberViewModel.Effect> {
    enum Effect {}
    
    @Inject private var workspaceRepo: any WorkspaceRepo
    
    // MARK: - State
    @Published var selection = segmentedButtonRoles[0]
    @Published var members: Flow<WorkspaceMembersChart> = .fetching
    @Published var searchText: String = ""
    @Published var isSearching: Bool = false
    
    // MARK: - Getter
    var selectedMembers: Flow<[RetrieveProfile]> {
        members.map {
            // 선생님을 선택했을 경우
            let selectedMembers = if selection == segmentedButtonRoles[0] {
                Array($0.admin.values) + Array($0.middleAdmin.values) + Array($0.teachers.values)
            } else {
                Array($0.students.values)
            }
            return selectedMembers.flatMap { $0 }
        }
    }
    
    var searchedMembers: Flow<[RetrieveProfile]> {
        guard !searchText.isEmpty else {
            return selectedMembers
        }
        return selectedMembers.map {
            $0.filter { $0.member.name.contains(searchText) }
        }
    }
    
    // MARK: - Method
    func fetchMembers(workspaceId: String) {
        workspaceRepo.getMembersChart(workspaceId: workspaceId)
            .map(\.data)
            .flow(\.members, on: self)
            .silentSink()
            .store(in: &subscriptions)
    }
}
