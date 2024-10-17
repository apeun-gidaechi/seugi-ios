import Combine
import Foundation
import Domain
import DateUtil

final class MealService: MealRepo {
    let runner: NetRunner

    init(runner: NetRunner) {
        self.runner = runner
    }

    func getAll(workspaceId: String) -> APIResult<Base<[Meal]>> {
        runner.deepDive(MealEndpoint.getAll(workspaceId: workspaceId), res: Base<[Meal]>.self)
    }
    
    func getByDate(workspaceId: String, date: Date) -> APIResult<Base<[Meal]>> {
        runner.deepDive(MealEndpoint.getByDate(workspaceId: workspaceId, date: date.parseString(type: .isoDate)), res: Base<[Meal]>.self)
    }
    
    func reset(workspaceId: String) -> APIResult<BaseVoid> {
        runner.deepDive(MealEndpoint.reset(workspaceId: workspaceId), res: BaseVoid.self)
    }
}
