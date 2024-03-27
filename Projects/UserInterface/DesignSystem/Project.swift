//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by dgsw8th71 on 3/22/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: ModulePaths.UserInterface.DesignSystem.rawValue,
    product: .staticFramework,
    targets: [
        .userInterface(name: ModulePaths.UserInterface.DesignSystem.rawValue, dependencies: [
            .shared(target: .SwiftUIUtil)
        ]),
        .example(name: ModulePaths.UserInterface.DesignSystem.rawValue, dependencies: [
            .userInterface(target: .DesignSystem)
        ])
    ],
    scripts: [.swiftLint],
    resources: ["Resources/**"]
)
