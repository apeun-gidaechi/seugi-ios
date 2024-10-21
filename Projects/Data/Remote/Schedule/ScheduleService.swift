import Domain

final class ScheduleService: ScheduleRepo {
    let runner: NetRunner
    init(runner: NetRunner) {
        self.runner = runner
    }
    
    func fetchSchedulesForYear(_ req: FetchSchedulesForYearReq) -> APIResult<Base<[Schedule]>> {
        runner.deepDive(ScheduleEndpoint.fetchSchedulesForYear(req), res: Base<[Schedule]>.self)
    }
    
    func fetchSchedulesForMonth(_ req: FetchSchedulesForMonthReq) -> APIResult<Base<[Schedule]>> {
        runner.deepDive(ScheduleEndpoint.fetchSchedulesForMonth(req), res: Base<[Schedule]>.self)
    }
}
