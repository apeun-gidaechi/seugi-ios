import Domain

final class TimetableService: Service<TimetableEndpoint>, TimetableRepo {
    func getWeekend(workspaceId: String) -> APIResult<Base<[Timetable]>> {
        performRequest(.getWeekend(workspaceId: workspaceId), res: [Timetable].self)
    }
    
    func getDay(workspaceId: String) -> APIResult<Base<[Timetable]>> {
        performRequest(.getDay(workspaceId: workspaceId), res: [Timetable].self)
    }
    
    func reset(workspaceId: String) -> APIResult<BaseVoid> {
        performRequest(.reset(workspaceId: workspaceId))
    }
}
