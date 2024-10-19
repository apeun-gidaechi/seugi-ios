import Combine
import WidgetKit
import Remote
import Domain
import DIContainer
import SwiftUtil

class MealProvider: TimelineProvider {
    typealias Entry = MealEntry
    
    private var subscriptions = Set<AnyCancellable>()
    
    @Inject private var mealRepo: MealRepo
    @Inject private var keyValueRepo: KeyValueRepo
    
    func placeholder(in context: Context) -> Entry {
        return .dummy
    }
    
    func getSnapshot(in context: Context, completion: @escaping (Entry) -> Void) {
        completion(.dummy)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        Log.debug("MealProvider.getTimeline is called.")
        
        let currentDate = Date()
        let nextUpdate = Calendar.current.date(byAdding: .hour, value: 1, to: currentDate)!
        
        guard let selectedWorkspace = keyValueRepo.load(key: .selectedWorkspaceId) as? String else {
            Log.error("MealProvider - selectedWorkspaceId is nil")
            completion(Timeline(entries: [MealEntry.of(currentDate)], policy: .after(nextUpdate)))
            return
        }
        
        mealRepo.getByDate(
            workspaceId: selectedWorkspace,
            date: .now
        )
        .map(\.data)
        .sink { result in
            print(result)
        } receiveValue: { meal in
            let type = MealType.from(.now)
            let entry = MealEntry(
                date: currentDate,
                meal: meal.filter { $0.mealType == type }.first
            )
            let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
            completion(timeline)
        }
        .store(in: &subscriptions)
    }
}
