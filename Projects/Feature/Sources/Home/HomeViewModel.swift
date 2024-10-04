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
import SwiftUtil

final class HomeViewModel: BaseViewModel<HomeViewModel.Effect> {
    enum Effect {}
    
    @Inject private var mealRepo: MealRepo
    @Inject private var timetableRepo: TimetableRepo
    
    @Published var meals: Flow<[Meal]> = .fetching
    @Published var timetables: Flow<[Timetable]> = .fetching
    
    func fetchMeals(workspaceId: String) {
        mealRepo.getByDate(workspaceId: workspaceId, date: .now)
            .map(\.data)
            .flow(\.meals, on: self)
            .silentSink()
            .store(in: &subscriptions)
    }
    
    func fetchTimetable(workspaceId: String) {
        timetableRepo.getDay(workspaceId: workspaceId)
            .map(\.data)
            .flow(\.timetables, on: self)
            .silentSink()
            .store(in: &subscriptions)
    }
}
