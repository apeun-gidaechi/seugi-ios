//
//  CatSeugiReq.swift
//  Domain
//
//  Created by hhhello0507 on 9/12/24.
//  Copyright © 2024 apeun-gidaechi. All rights reserved.
//

import Foundation

public struct CatSeugiSendMessageReq: Encodable {
    public let text: String
    
    public init(text: String) {
        self.text = text
    }
}
