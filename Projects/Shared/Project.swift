//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by dgsw8th71 on 3/26/24.
//

import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeShared(
    targets: [
        .shared(target: .DateUtil),
        .shared(target: .SwiftUIUtil),
        .shared(target: .SwiftUtil)
    ],
    xcconfig: .relativeToXCConfig("Config.xcconfig")
)
