import Domain

final class AssignmentService: AssignmentRepo {
    let runner: NetRunner
    
    init(runner: NetRunner) {
        self.runner = runner
    }
    
    func fetchTasks(workspaceId: String) -> APIResult<Base<[AssignmentEntity]>> {
        runner.deepDive(AssignmentEndpoint.getTasks(workspaceId: workspaceId), res: Base<[AssignmentEntity]>.self)
    }
    
    func fetchClassroomTasks() -> APIResult<Base<[ClassroomTask]>> {
        runner.deepDive(AssignmentEndpoint.getClassroomTasks, res: Base<[ClassroomTask]>.self)
    }
    
    func createAssignment(_ req: CreateAssignmentReq) -> APIResult<BaseVoid> {
        runner.deepDive(AssignmentEndpoint.createAssignment(req), res: BaseVoid.self)
    }
}
