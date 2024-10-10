import Foundation
import DIContainer
import Domain
import SwiftUtil
import Combine

final class InvitateMemberViewModel: ObservableObject {
    var subscriptions = Set<AnyCancellable>()
    
    @Inject private var workspaceRepo: any WorkspaceRepo
    
    // MARK: - Properties
    @Published var selection = segmentedButtonRoles[0]
    @Published var workspaceCode: Flow<String> = .fetching
    @Published private var studentWaitMembers: Flow<[RetrieveMember]> = .fetching
    @Published private var teacherWaitMembers: Flow<[RetrieveMember]> = .fetching
    var waitMembers: Flow<[RetrieveMember]> {
        if selection == segmentedButtonRoles[0] {
            teacherWaitMembers
        } else {
            studentWaitMembers
        }
    }
    @Published var selectedMembers: [RetrieveMember] = []
    @Published var addWorkspaceFlow: Flow<BaseVoid> = .idle
    @Published var cancelWorkspaceFlow: Flow<BaseVoid> = .idle
    
    // MARK: - Method
    func fetchWaitMembers(workspaceId: String) {
        workspaceRepo.getWaitList(workspaceId: workspaceId, workspaceRole: .student)
            .map(\.data)
            .flow(\.studentWaitMembers, on: self)
            .silentSink()
            .store(in: &subscriptions)
        workspaceRepo.getWaitList(workspaceId: workspaceId, workspaceRole: .teacher)
            .map(\.data)
            .flow(\.teacherWaitMembers, on: self)
            .silentSink()
            .store(in: &subscriptions)
    }
    
    func fetchWorkspaceCode(workspaceId: String) {
        workspaceRepo.getWorkspaceCode(workspaceId: workspaceId)
            .map(\.data)
            .flow(\.workspaceCode, on: self)
            .silentSink()
            .store(in: &subscriptions)
    }
    
    func selectMember(member: RetrieveMember) {
        if selectedMembers.contains(member) {
            selectedMembers.removeAll { $0 == member }
        } else {
            selectedMembers.append(member)
        }
    }
    
    func addWorkspace(workspaceId: String) {
        workspaceRepo.addWorkspace(
            workspaceId: workspaceId,
            userSet: selectedMembers.map { $0.id },
            role: selection.role
        )
        .flow(\.addWorkspaceFlow, on: self)
        .silentSink()
        .store(in: &subscriptions)
    }
    
    func cancelWorkspace(workspaceId: String) {
        workspaceRepo.cancelWorkspace(
            workspaceId: workspaceId,
            userSet: selectedMembers.map { $0.id },
            role: selection.role
        )
        .flow(\.cancelWorkspaceFlow, on: self)
        .silentSink()
        .store(in: &subscriptions)
    }
}
