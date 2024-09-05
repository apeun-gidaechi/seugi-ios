//
//  KeyStoreAssembly.swift
//  Core
//
//  Created by hhhello0507 on 9/5/24.
//  Copyright © 2024 apeun-gidaechi. All rights reserved.
//

import Foundation
import Swinject
import Domain

public final class KeychainAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(KeychainRepo.self) { _ in
            KeychainStore()
        }
    }
}
