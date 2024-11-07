import Combine

public protocol AssignmentRepo {
    func fetchTasks(workspaceId: String) -> APIResult<Base<[AssignmentEntity]>>
    func fetchClassroomTasks() -> APIResult<Base<[ClassroomTask]>>
    func createAssignment(_ req: CreateAssignmentReq) -> APIResult<BaseVoid>
}
