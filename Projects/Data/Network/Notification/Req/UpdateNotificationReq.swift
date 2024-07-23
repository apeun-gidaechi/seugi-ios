//
//  UpdateNotificationReq.swift
//  Core
//
//  Created by hhhello0507 on 7/23/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import Foundation

struct UpdateNotificationReq: Encodable {
    let id: Int
    let title: String
    let content: String
}
