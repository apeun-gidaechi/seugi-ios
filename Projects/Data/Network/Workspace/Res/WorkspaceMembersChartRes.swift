//
//  WorkspaceMembersChartRes.swift
//  Network
//
//  Created by hhhello0507 on 7/25/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import Domain

public struct WorkspaceMembersChartRes: SeugiResponse {
    let teachers: [String: [RetrieveProfileRes]]
    let students: [String: [RetrieveProfileRes]]
    
    func toEntity() -> WorkspaceMembersChart {
        WorkspaceMembersChart(
            teachers: teachers.mapValues { $0.toEntity() },
            students: students.mapValues { $0.toEntity() }
        )
    }
}
