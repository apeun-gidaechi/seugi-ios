//
//  Timetable.swift
//  Domain
//
//  Created by hhhello0507 on 9/11/24.
//  Copyright © 2024 apeun-gidaechi. All rights reserved.
//

import Foundation

public struct Timetable: Entity {
    public let id: Int
    public let workspaceId: String
    public let grade: String
    public let classNum: String
    public let time: String
    public let subject: String
    public let date: String
    
    public init(id: Int, workspaceId: String, grade: String, classNum: String, time: String, subject: String, date: String) {
        self.id = id
        self.workspaceId = workspaceId
        self.grade = grade
        self.classNum = classNum
        self.time = time
        self.subject = subject
        self.date = date
    }
}
