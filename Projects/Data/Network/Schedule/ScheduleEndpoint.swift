import Domain

enum ScheduleEndpoint {
    case fetchSchedulesForYear(FetchSchedulesForYearReq)
    case fetchSchedulesForMonth(FetchSchedulesForMonthReq)
}

extension ScheduleEndpoint: SeugiEndpoint {
    var host: String { "schedule" }
    var route: Route {
        switch self {
        case .fetchSchedulesForYear(let req):
                .get()
                .task(req.toURLParameters())
        case .fetchSchedulesForMonth(let req):
                .get()
                .task(req.toURLParameters())
        }
    }
}
