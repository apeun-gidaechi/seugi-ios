//
//  KeyStoreRepo.swift
//  Domain
//
//  Created by hhhello0507 on 9/5/24.
//  Copyright © 2024 apeun-gidaechi. All rights reserved.
//

import Foundation

public protocol KeychainRepo {
    func save(key: KeychainKeys, value: String)
    func load(key: KeychainKeys) -> String?
    func delete(key: KeychainKeys)
}
