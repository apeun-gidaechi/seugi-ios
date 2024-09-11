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

final class HomeViewModel: BaseViewModel<HomeViewModel.Effect> {
    enum Effect {}
    
    @Inject private var mealRepo: MealRepo
    @Inject private var timetableRepo: TimetableRepo
    
    @Published var meals: FetchFlow<[Meal]> = .fetching
    @Published var timetables: FetchFlow<[Timetable]> = .fetching
    
    func fetchMeals(workspaceId: String) {
        sub(mealRepo.getByDate(workspaceId: workspaceId, date: .now)) {
            self.meals = .fetching
        } success: { res in
            self.meals = .success(res.data)
        } failure: { err in
            self.meals = .failure(err)
        }
    }
    
    func fetchTimetable(workspaceId: String) {
        sub(timetableRepo.getDay(workspaceId: workspaceId)) {
            self.timetables = .fetching
        } success: { res in
            self.timetables = .success(res.data)
        } failure: { err in
            self.timetables = .failure(err)
        }
    }
}
