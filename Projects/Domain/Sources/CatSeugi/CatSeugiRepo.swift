//
//  CatSeugiRepo.swift
//  Domain
//
//  Created by hhhello0507 on 9/12/24.
//  Copyright © 2024 apeun-gidaechi. All rights reserved.
//

import Foundation

public protocol CatSeugiRepo {
    func sendMessage(_ req: CatSeugiSendMessageReq) -> APIResult<Base<String>>
}
