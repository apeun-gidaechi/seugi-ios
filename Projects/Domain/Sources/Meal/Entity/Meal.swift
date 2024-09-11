//
//  Meal.swift
//  Domain
//
//  Created by hhhello0507 on 9/11/24.
//  Copyright © 2024 apeun-gidaechi. All rights reserved.
//

import Foundation

public struct Meal: Entity {
    public let id: Int
    public let workspaceId: String
    public let mealType: MealType
    public let menu: [String]
    public let calorie: String
    public let mealInfo: [String]
    public let mealDate: String
    
    public init(id: Int, workspaceId: String, mealType: MealType, menu: [String], calorie: String, mealInfo: [String], mealDate: String) {
        self.id = id
        self.workspaceId = workspaceId
        self.mealType = mealType
        self.menu = menu
        self.calorie = calorie
        self.mealInfo = mealInfo
        self.mealDate = mealDate
    }
}
