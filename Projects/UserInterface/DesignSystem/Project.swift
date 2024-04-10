//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by dgsw8th71 on 3/22/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeUserInterface(
    target: .DesignSystem,
    targets: [
        .userInterface(target: .DesignSystem, dependencies: [
            .shared(target: .SwiftUIUtil)
        ]),
        .userInterfaceExample(target: .DesignSystem, dependencies: [
            .userInterface(target: .DesignSystem)
        ])
    ]
)
