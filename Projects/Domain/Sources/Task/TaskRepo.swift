import Combine

public protocol TaskRepo {
    func fetchTasks(workspaceId: String) -> APIResult<Base<[Domain.Task]>>
    func createTask(_ req: CreateTaskReq) -> APIResult<BaseVoid>
}
