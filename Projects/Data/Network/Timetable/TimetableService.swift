//
//  TimetableService.swift
//  Network
//
//  Created by hhhello0507 on 9/11/24.
//  Copyright © 2024 apeun-gidaechi. All rights reserved.
//

import Domain

final class TimetableService: Service<TimetableEndpoint>, TimetableRepo {
    func getWeekend(workspaceId: String) -> ObservableResult<Base<[Timetable]>> {
        performRequest(.getWeekend(workspaceId: workspaceId), res: [Timetable].self)
    }
    
    func getDay(workspaceId: String) -> ObservableResult<Base<[Timetable]>> {
        performRequest(.getDay(workspaceId: workspaceId), res: [Timetable].self)
    }
    
    func reset(workspaceId: String) -> ObservableResult<BaseVoid> {
        performRequest(.reset(workspaceId: workspaceId))
    }
}
