import Foundation
import Combine
import Domain
import DIContainer
import DateUtil
import SwiftUtil

final class MealViewModel: ObservableObject {
    private var subscriptions = Set<AnyCancellable>()
    
    @Inject var mealRepo: MealRepo
    
    @Published var meals: Flow<[Meal]> = .idle
    @Published var selectedDate: Date = .now
    var selectedMeal: [Meal]? {
        meals.data?.filter {
            $0.mealDate.equals(selectedDate, components: [.year, .month, .day])
        }
    }
    @Published var selectedCalendar: Date = .now
    var isFirstOnAppear: Bool = true
}

extension MealViewModel: OnAppearProtocol {
    func fetchAllData(workspaceId: String) {
        self.fetchMealData(workspaceId: workspaceId)
    }
}
    
extension MealViewModel {
    func fetchMealData(workspaceId: String) {
        mealRepo.getAll(workspaceId: workspaceId)
            .map(\.data)
            .map { $0.sorted { $0.mealType < $1.mealType } }
            .flow(\.meals, on: self)
            .silentSink()
            .store(in: &subscriptions)
    }
}
