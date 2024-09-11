//
//  MealType.swift
//  Domain
//
//  Created by hhhello0507 on 9/11/24.
//  Copyright © 2024 apeun-gidaechi. All rights reserved.
//

import Foundation

public enum MealType: String, Entity, Comparable {
    
    case breakfask = "조식"
    case launch = "중식"
    case dinner = "석식"
    
    private var priority: Int {
        switch self {
        case .breakfask: 0
        case .launch: 1
        case .dinner: 2
        }
    }
    
    public static func < (lhs: MealType, rhs: MealType) -> Bool {
        lhs.priority < rhs.priority
    }
}
