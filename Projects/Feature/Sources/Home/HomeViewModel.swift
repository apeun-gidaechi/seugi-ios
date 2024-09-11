//
//  HomeViewModel.swift
//  HomeFeature
//
//  Created by hhhello0507 on 7/23/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import Foundation
import DIContainer
import Domain

final class HomeViewModel: BaseViewModel<HomeViewModel.HomeSubject> {
    enum HomeSubject {}
    
    @Inject private var mealRepo: MealRepo
    
    @Published var meals: FetchFlow<[Meal]> = .fetching
    
    func fetchMeals(workspaceId: String) {
        sub(mealRepo.getByDate(workspaceId: workspaceId, date: .now)) {
            self.meals = .fetching
        } success: { res in
            self.meals = .success(res.data)
        } failure: { err in
            self.meals = .failure(err)
        }
    }
}
