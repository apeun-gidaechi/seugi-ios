//
//  LocalChatRepo.swift
//  Domain
//
//  Created by hhhello0507 on 9/1/24.
//  Copyright © 2024 apeun-gidaechi. All rights reserved.
//

import Foundation

public protocol LocalChatRepo {
    func insertGroup(workspaceId: String, room: Room) throws
    func getGroupAll(workspaceId: String) throws -> [Room]
    func removeGroupAll() throws
}
