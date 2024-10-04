import Foundation

public protocol MealRepo {
    func getAll(workspaceId: String) -> APIResult<Base<[Meal]>>
    func getByDate(workspaceId: String, date: Date) -> APIResult<Base<[Meal]>>
    func reset(workspaceId: String) -> APIResult<BaseVoid>
}
