//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by dgsw8th71 on 1/4/24.
//

import ProjectDescription
import ProjectDescriptionHelpers
import EnvironmentPlugin
import DependencyPlugin

let project = Project.make(
    name: "Seugi",
    targets: [
        Target.target(
            name: "Seugi-iOS",
            destinations: env.destinations,
            product: .app,
            bundleId: baseBundleId,
            deploymentTargets: env.deploymentTargets,
            infoPlist: .file(path: "Seugi-iOS/Support/Info.plist"),
            sources: ["Seugi-iOS/Sources/**"],
            resources: ["Seugi-iOS/Resources/**"],
            entitlements: .file(path: "Seugi-iOS/Support/App.entitlements"),
            scripts: [.swiftLint],
            dependencies: Modules.Data.allCases.map { TargetDependency.data(of: $0) }
            + [.diContainer, .feature],
            settings: makeSettings()
        ),
        Target.target(
            name: "Aggregate",
            destinations: [.iPhone],
            product: .bundle,
            bundleId: "\(baseBundleId).aggregate",
            scripts: [.periphery]
        )
    ]
)
