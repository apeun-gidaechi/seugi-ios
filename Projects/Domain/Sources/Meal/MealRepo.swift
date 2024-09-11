//
//  MealRepo.swift
//  Domain
//
//  Created by hhhello0507 on 9/11/24.
//  Copyright © 2024 apeun-gidaechi. All rights reserved.
//

import Foundation
public protocol MealRepo {
    func getAll(workspaceId: String) -> APIResult<Base<[Meal]>>
    func getByDate(workspaceId: String, date: Date) -> APIResult<Base<[Meal]>>
    func reset(workspaceId: String) -> APIResult<BaseVoid>
}
