import Combine
import Foundation
import Domain
import DIContainer
import SwiftUtil

final class TaskViewModel: ObservableObject {
    private var subscriptions = Set<AnyCancellable>()
    
    @Inject private var taskRepo: TaskRepo
    
    @Published var tasks: Flow<[TaskEntity]> = .fetching
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
        taskRepo.fetchTasks(workspaceId: workspaceId)
            .map(\.data)
            .flow(\.tasks, on: self)
            .silentSink()
            .store(in: &subscriptions)
    }
    
    func fetchClassroomTasks() {
        taskRepo.fetchClassroomTasks()
            .map(\.data)
            .flow(\.classroomTasks, on: self)
            .silentSink()
            .store(in: &subscriptions)
    }
}
