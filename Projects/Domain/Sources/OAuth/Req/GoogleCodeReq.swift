//
//  GoogleCodeReq.swift
//  Domain
//
//  Created by hhhello0507 on 9/11/24.
//  Copyright © 2024 apeun-gidaechi. All rights reserved.
//

import Foundation

public struct GoogleCodeReq: Encodable {
    public let code: String
    public init(code: String) {
        self.code = code
    }
}
