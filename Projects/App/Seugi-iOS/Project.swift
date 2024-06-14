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
            type: .iOS,
            dependenceis: ModulePaths.Feature.allCases.map { TargetDependency.feature(of: $0, module: $0 == .Base ? .Interface : .Feature) }
            + ModulePaths.Data.allCases.map { TargetDependency.data(of: $0) }
            + [.diContainer],
            infoPlist: .file(path: "Support/Info.plist"),
            entitlements: .file(path: "Support/App.entitlements")
        )
    ],
    xcconfig: .relativeToXCConfig("Config.xcconfig")
)
