//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by hhhello0507 on 8/23/24.
//

import ProjectDescription
import ProjectDescriptionHelpers
import EnvironmentPlugin

let project = Project(
    name: "Feature",
    targets: [
        .init(
            name: "Feature",
            destinations: .iOS,
            product: .staticLibrary,
            bundleId: "com.\(env.name).feature",
            deploymentTargets: env.deploymentTargets,
            sources: ["Sources/**"],
            dependencies: [
                .domain,
                .component
            ]
        )
    ]
)
