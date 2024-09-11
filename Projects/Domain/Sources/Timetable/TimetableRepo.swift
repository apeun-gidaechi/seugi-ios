//
//  TimetableRepo.swift
//  Domain
//
//  Created by hhhello0507 on 9/11/24.
//  Copyright © 2024 apeun-gidaechi. All rights reserved.
//

import Foundation

public protocol TimetableRepo {
    func getWeekend(workspaceId: String) -> ObservableResult<Base<[Timetable]>>
    func getDay(workspaceId: String) -> ObservableResult<Base<[Timetable]>>
    func reset(workspaceId: String) -> ObservableResult<BaseVoid>
}
