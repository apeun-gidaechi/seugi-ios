import Combine

public protocol TaskRepo {
    func fetchTasks(workspaceId: String) -> APIResult<Base<[TaskEntity]>>
    func fetchClassroomTasks() -> APIResult<Base<[ClassroomTask]>>
    func createTask(_ req: CreateTaskReq) -> APIResult<BaseVoid>
}
