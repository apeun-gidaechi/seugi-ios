public protocol ScheduleRepo {
    func fetchSchedulesForYear(_ req: FetchSchedulesForYearReq) -> APIResult<Base<[Schedule]>>
    func fetchSshedulesForMonth(_ req: FetchSchedulesForMonthReq) -> APIResult<Base<[Schedule]>>
}
