//
//  LogoutReq.swift
//  Domain
//
//  Created by hhhello0507 on 9/19/24.
//  Copyright © 2024 apeun-gidaechi. All rights reserved.
//

import Foundation

public struct LogoutReq: Encodable {
    public let fcmToken: String
    public init(fcmToken: String) {
        self.fcmToken = fcmToken
    }
}
