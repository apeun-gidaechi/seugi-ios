//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by dgsw8th71 on 3/27/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeShared(
    target: .SwiftUIUtil,
    targets: [
        .shared(target: .SwiftUIUtil, dependencies: [])
    ]
)
