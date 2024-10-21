import Domain

final class TaskService: TaskRepo {
    let runner: NetRunner
    
    init(runner: NetRunner) {
        self.runner = runner
    }
    
    func fetchTasks(workspaceId: String) -> APIResult<Base<[TaskEntity]>> {
        runner.deepDive(TaskEndpoint.getTasks(workspaceId: workspaceId), res: Base<[TaskEntity]>.self)
    }
    
    func fetchClassroomTasks() -> APIResult<Base<[ClassroomTask]>> {
        runner.deepDive(TaskEndpoint.getClassroomTasks, res: Base<[ClassroomTask]>.self)
    }
    
    func createTask(_ req: CreateTaskReq) -> APIResult<BaseVoid> {
        runner.deepDive(TaskEndpoint.createTask(req), res: BaseVoid.self)
    }
}
