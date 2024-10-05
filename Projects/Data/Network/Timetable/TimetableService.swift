import Domain

final class TimetableService: TimetableRepo {
    let runner: NetRunner

    init(runner: NetRunner) {
        self.runner = runner
    }

    func getWeekend(workspaceId: String) -> APIResult<Base<[Timetable]>> {
        runner.deepDive(TimetableEndpoint.getWeekend(workspaceId: workspaceId), res: Base<[Timetable]>.self)
    }

    func getDay(workspaceId: String) -> APIResult<Base<[Timetable]>> {
        runner.deepDive(TimetableEndpoint.getDay(workspaceId: workspaceId), res: Base<[Timetable]>.self)
    }

    func reset(workspaceId: String) -> APIResult<BaseVoid> {
        runner.deepDive(TimetableEndpoint.reset(workspaceId: workspaceId), res: BaseVoid.self)
    }
}
