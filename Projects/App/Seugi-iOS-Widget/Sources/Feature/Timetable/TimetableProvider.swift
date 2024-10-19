import Combine
import WidgetKit
import Domain
import DIContainer
import SwiftUtil

final class TimetableProvider: TimelineProvider {
    typealias Entry = TimetableEntry
    
    private var subscriptions = Set<AnyCancellable>()
    
    @Inject var timetableRepo: TimetableRepo
    @Inject var keyValueRepo: KeyValueRepo
    
    func getSnapshot(in context: Context, completion: @escaping (Entry) -> Void) {
        completion(.dummy)
    }
    
    func placeholder(in context: Context) -> TimetableEntry {
        return .dummy
    }
    
    func getTimeline(in context: Context, completion: @escaping @Sendable (Timeline<TimetableEntry>) -> Void) {
        Log.debug("TimetableProvider.getTimeline is called.")
        
        let currentDate = Date()
        let nextUpdate = Calendar.current.date(byAdding: .hour, value: 2, to: currentDate)!
        
        guard let workspaceId: String = keyValueRepo.load(key: .selectedWorkspaceId) else {
            Log.error("TimetableProvider - selectedWorkspaceId is nil")
            completion(Timeline(entries: [TimetableEntry.of(currentDate)], policy: .after(nextUpdate)))
            return
        }
        
        timetableRepo.getDay(
            workspaceId: workspaceId
        )
        .map(\.data)
        .sink { result in
            print(result)
        } receiveValue: { timetables in
            let entry = TimetableEntry(
                date: currentDate,
                timetables: timetables
            )
            let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
            completion(timeline)
        }
        .store(in: &subscriptions)
    }
}
