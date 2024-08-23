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
            dependenceis: ModulePaths.Data.allCases.map { TargetDependency.data(of: $0) }
            + [.diContainer, .feature],
            infoPlist: .file(path: "Seugi-\(ModulePaths.App.iOS.rawValue)/Support/Info.plist"),
            entitlements: .file(path: "Seugi-\(ModulePaths.App.iOS.rawValue)/Support/App.entitlements")
        )
    ],
    xcconfig: .relativeToXCConfig("Config.xcconfig")
)
