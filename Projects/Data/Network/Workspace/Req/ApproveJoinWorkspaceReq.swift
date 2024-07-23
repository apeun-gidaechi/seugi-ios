//
//  ApproveJoinWorkspaceReq.swift
//  Network
//
//  Created by hhhello0507 on 7/23/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import Foundation
import Domain

public struct ApproveJoinWorkspaceReq: Encodable {
    let workspaceId: String
    let approvalUserSet: [Int]
    let role: WorkspaceRole
}
