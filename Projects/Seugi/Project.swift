//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by dgsw8th71 on 1/4/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeApp(
    targets: [
        .app(
            target: .App,
            dependenceis:
                ModulePaths.Feature.allCases.map { TargetDependency.feature(.Feature, for: $0) }
            + ModulePaths.Domain.allCases.map { TargetDependency.domain(.Feature, for: $0) }
            + [.dIContainer(.Feature, for: .DIContainer)],
            infoPlist: .file(path: "Support/Info.plist"),
            entitlements: .file(path: "Support/App.entitlements")
        )
    ], 
    xcconfig: .relativeToXCConfig("Config.xcconfig")
)
