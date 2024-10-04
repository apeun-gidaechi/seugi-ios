public protocol TimetableRepo {
    func getWeekend(workspaceId: String) -> APIResult<Base<[Timetable]>>
    func getDay(workspaceId: String) -> APIResult<Base<[Timetable]>>
    func reset(workspaceId: String) -> APIResult<BaseVoid>
}
