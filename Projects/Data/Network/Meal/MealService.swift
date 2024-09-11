import Domain
import Combine
import Foundation

final class MealService: Service<MealEndpoint>, MealRepo {
    func getAll(workspaceId: String) -> ObservableResult<Base<[Meal]>> {
        performRequest(.getAll(workspaceId: workspaceId), res: [Meal].self)
    }
    
    func getByDate(workspaceId: String, date: Date) -> ObservableResult<Base<[Meal]>> {
        performRequest(.getByDate(workspaceId: workspaceId, date: date.parseString("yyyyMMdd")), res: [Meal].self)
    }
    
    func reset(workspaceId: String) -> ObservableResult<BaseVoid> {
        performRequest(.reset(workspaceId: workspaceId))
    }
}
