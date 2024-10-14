import Combine
import Foundation
import DIContainer
import Domain
import SwiftUtil
import DateUtil

final class HomeViewModel: ObservableObject {
    var subscriptions = Set<AnyCancellable>()
    
    @Inject private var mealRepo: MealRepo
    @Inject private var timetableRepo: TimetableRepo
    @Inject private var scheduleRepo: ScheduleRepo
    
    @Published var meals: Flow<[Meal]> = .fetching
    @Published var timetables: Flow<[Timetable]> = .fetching
    @Published var schedules: Flow<[Schedule]> = .fetching
    
    var isFirstOnAppear: Bool = true
}

extension HomeViewModel: OnAppearProtocol {
    func fetchAllData(workspaceId: String) {
        self.fetchMeals(workspaceId: workspaceId)
        self.fetchTimetable(workspaceId: workspaceId)
        self.fetchSchedules(workspaceId: workspaceId)
    }
}

extension HomeViewModel {
    func fetchMeals(workspaceId: String) {
        mealRepo.getByDate(workspaceId: workspaceId, date: .now)
            .map(\.data)
            .flow(\.meals, on: self)
            .silentSink()
            .store(in: &subscriptions)
    }
    
    func fetchTimetable(workspaceId: String) {
        timetableRepo.getDay(workspaceId: workspaceId)
            .map(\.data)
            .flow(\.timetables, on: self)
            .silentSink()
            .store(in: &subscriptions)
    }
    
    func fetchSchedules(workspaceId: String) {
        scheduleRepo.fetchSshedulesForMonth(
            .init(
                workspaceId: workspaceId,
                month: Date.now[.day]
            )
        )
        .map(\.data)
        .flow(\.schedules, on: self)
        .silentSink()
        .store(in: &subscriptions)
    }
}
