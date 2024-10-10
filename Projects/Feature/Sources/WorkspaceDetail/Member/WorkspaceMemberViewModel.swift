import Foundation
import Domain
import DIContainer
import SwiftUtil
import Combine

final class WorkspaceMemberViewModel: ObservableObject {
    var subscriptions = Set<AnyCancellable>()
    
    @Inject private var workspaceRepo: WorkspaceRepo
    
    @Published var selection = segmentedButtonRoles[0]
    @Published var members: Flow<WorkspaceMembersChart> = .fetching
    @Published var searchText: String = ""
    @Published var isSearching: Bool = false
    
    var selectedMembers: Flow<[RetrieveProfile]> {
        return members.map {
            // 선생님을 선택했을 경우
            if selection == segmentedButtonRoles[0] {
                $0.allTeachers
            } else {
                Array($0.students.values).flatMap(\.self)
            }
        }
    }
    
    var searchedMembers: Flow<[RetrieveProfile]> {
        selectedMembers.map { $0.search(text: searchText) }
    }
}

extension WorkspaceMemberViewModel {
    func fetchMembers(workspaceId: String) {
        workspaceRepo.getMembersChart(workspaceId: workspaceId)
            .map(\.data)
            .flow(\.members, on: self)
            .silentSink()
            .store(in: &subscriptions)
    }
}
