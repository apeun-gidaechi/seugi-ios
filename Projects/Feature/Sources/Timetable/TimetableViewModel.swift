import Foundation
import Combine
import Domain
import DIContainer
import SwiftUtil

final class TimetableViewModel: ObservableObject {
    private var subscriptions = Set<AnyCancellable>()
    
    @Inject private var timetableRepo: TimetableRepo
    
    @Published var timetables: Flow<[[Timetable?]]> = .idle
    @Published var selectedMonth: Date = .now
    @Published var maxCount = 0
    
    var isFirstOnAppear: Bool = true
}

extension TimetableViewModel: OnAppearProtocol {
    func fetchAllData(workspaceId: String) {
        fetchTimetables(workspaceId: workspaceId)
    }
}

extension TimetableViewModel {
    func fetchTimetables(workspaceId: String) {
        timetableRepo.getWeekend(workspaceId: workspaceId)
            .ignoreError()
            .map(\.data)
            .map {
                let groupedTimetables = $0.groupBy {
                    $0.date.equals($1.date, components: [.year, .month, .day])
                }
                let sortedTimetables: [[Timetable?]] = groupedTimetables.map {
                    $0.sorted { Int($0.time) ?? 0 < Int($1.time) ?? 0 }
                }
                guard let maxCountTimetables = groupedTimetables.max(by: { $0.count < $1.count }) else {
                    return sortedTimetables
                }
                self.maxCount = maxCountTimetables.count
                
                var adjustTimetables = sortedTimetables
                
                if adjustTimetables.count > 5 {
                    adjustTimetables = Array(adjustTimetables[0..<5])
                }
                
                for index in adjustTimetables.indices {
                    var rows = adjustTimetables[index]
                    
                    rows.append(contentsOf: Array(repeating: nil, count: self.maxCount - rows.count))
                    adjustTimetables[index] = rows
                }
                
                return adjustTimetables
            }
            .flow(\.timetables, on: self)
            .silentSink()
            .store(in: &subscriptions)
    }
}
