//
//  SegmentedRole.swift
//  SettingWorkspaceFeature
//
//  Created by hhhello0507 on 7/24/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import Foundation
import Component

struct SegmentedButtonRole: SegmentedButtonProtocol {
    var label: String
}

let segmentedButtonRoles: [SegmentedButtonRole] = [
    .init(label: "선생님"),
    .init(label: "학생")
]
