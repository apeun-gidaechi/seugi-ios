import Domain

final class TaskService: TaskRepo {
    let runner: NetRunner
    
    init(runner: NetRunner) {
        self.runner = runner
    }
    
    func fetchTasks(workspaceId: String) -> APIResult<Base<[Domain.Task]>> {
        runner.deepDive(TaskEndpoint.getTasks(workspaceId: workspaceId), res: Base<[Domain.Task]>.self)
    }
    
    func createTask(_ req: CreateTaskReq) -> APIResult<BaseVoid> {
        runner.deepDive(TaskEndpoint.createTask(req), res: BaseVoid.self)
    }
}
