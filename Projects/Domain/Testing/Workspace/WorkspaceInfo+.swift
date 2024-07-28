//
//  WorkspaceInfo+.swift
//  DomainTesting
//
//  Created by hhhello0507 on 7/28/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import Foundation
import Domain

extension WorkspaceInfo: Mock {
    public static func mock() -> WorkspaceInfo {
        .init(
            workspaceId: .randomUUID(),
            workspaceName: .randomUUID(),
            workspaceImageUrl: .randomUUID(),
            studentCount: .randomIn100(),
            teacherCount: .randomIn10()
        )
    }
}
