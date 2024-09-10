//
//  TimetableEndpoint.swift
//  Core
//
//  Created by hhhello0507 on 9/11/24.
//  Copyright © 2024 apeun-gidaechi. All rights reserved.
//

import Moya

enum TimetableEndpoint: SeugiEndpoint {
    
    case getWeekend(workspaceId: String)
    case getDay(workspaceId: String)
    case reset(workspaceId: String)
}

extension TimetableEndpoint {
    static let authProvider: MoyaProvider<Self> = .init(session: session)
    static let provider: MoyaProvider<Self> = .init(session: authSession)
    
    var host: String {
        "timetable"
    }
    
    var route: (Moya.Method, String, Moya.Task) {
        switch self {
        case .getWeekend(let workspaceId):
                .get - "weekend" - ["workspaceId": workspaceId].toURLParameters()
        case .getDay(let workspaceId):
                .get - "day" - ["workspaceId": workspaceId].toURLParameters()
        case .reset(let workspaceId):
                .post - "reset" - ["workspaceId": workspaceId].toURLParameters()
        }
    }
}
