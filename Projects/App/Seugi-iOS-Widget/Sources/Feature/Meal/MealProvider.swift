import Combine
import WidgetKit
import Network
import Domain
import DIContainer
import SwiftUtil

class MealProvider: TimelineProvider {
    typealias Entry = MealEntry
    
    private var subscription = Set<AnyCancellable>()
    
    @Inject private var mealRepo: MealRepo
    @Inject private var keyValueRepo: KeyValueRepo
    
    func placeholder(in context: Context) -> Entry {
        return .empty
    }
    
    func getSnapshot(in context: Context, completion: @escaping (Entry) -> Void) {
        completion(.empty)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        Log.debug("MealProvider.getTimeline is called.")
        let nextUpdate = Calendar.current.date(byAdding: .hour, value: 1, to: .now)!
        let currentDate = Date()
        
        guard let selectedWorkspace = keyValueRepo.load(key: .selectedWorkspaceId) as? String else {
            Log.error("MealProvider - selectedWorkspaceId is nil")
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
        .store(in: &subscription)
    }
}
