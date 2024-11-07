import Combine
import Foundation
import Domain
import DIContainer
import SwiftUtil

final class TaskViewModel: ObservableObject {
    private var subscriptions = Set<AnyCancellable>()
    
    @Inject private var assignmentRepo: AssignmentRepo
    
    @Published var tasks: Flow<[AssignmentEntity]> = .fetching
    @Published var classroomTasks: Flow<[ClassroomTask]> = .fetching
    
    var isFirstOnAppear: Bool = true
}

extension TaskViewModel: OnAppearProtocol {
    func fetchAllData(workspaceId: String) {
        self.fetchTasks(workspaceId: workspaceId)
        self.fetchClassroomTasks()
    }
}

extension TaskViewModel {
    func fetchTasks(workspaceId: String) {
        assignmentRepo.fetchTasks(workspaceId: workspaceId)
            .map(\.data)
            .flow(\.tasks, on: self)
            .silentSink()
            .store(in: &subscriptions)
    }
    
    func fetchClassroomTasks() {
        assignmentRepo.fetchClassroomTasks()
            .map(\.data)
            .flow(\.classroomTasks, on: self)
            .silentSink()
            .store(in: &subscriptions)
    }
}
