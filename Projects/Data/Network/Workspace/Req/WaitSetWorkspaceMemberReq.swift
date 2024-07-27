//
//  WaitSetWorkspaceMemberReq.swift
//  Network
//
//  Created by hhhello0507 on 7/23/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import Foundation
import Domain

public struct WaitSetWorkspaceMemberReq: Encodable {
    let workspaceId: String
    let userSet: [Int]
    let role: WorkspaceRole
}
