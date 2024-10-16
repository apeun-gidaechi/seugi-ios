//import Combine
//import WidgetKit
//import Network
//
//class MealProvider: TimelineProvider {
//    private var subscription = Set<AnyCancellable>()
//    
//    typealias Entry = MealEntry
//    func placeholder(in context: Context) -> Entry {
//        return .empty
//    }
//    
//    func getSnapshot(in context: Context, completion: @escaping (Entry) -> Void) {
//        completion(.empty)
//    }
//    
//    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
//        let nextUpdate = Calendar.current.date(byAdding: .hour, value: 1, to: .now)!
//        let currentDate = Date()
//        
//        MealService.shared.fetchMeals(
//            .init()
//        )
//        .ignoreError()
//        .sink { meal in
//            let type = MealType.from(.now)
//            let entry = MealEntry(
//                date: currentDate,
//                meal: meal.filter { $0.mealType == type }.first
//            )
//            let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
//            completion(timeline)
//        }
//        .store(in: &subscription)
//        
//    }
//}
