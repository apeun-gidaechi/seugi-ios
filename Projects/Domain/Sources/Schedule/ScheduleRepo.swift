public protocol ScheduleRepo {
    func fetchSchedulesForYear(_ req: FetchSchedulesForYearReq) -> APIResult<Base<[Schedule]>>
    func fetchSchedulesForMonth(_ req: FetchSchedulesForMonthReq) -> APIResult<Base<[Schedule]>>
}
