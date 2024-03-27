//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by dgsw8th71 on 1/4/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: ModulePaths.App.App.rawValue,
    product: .app,
    scripts: [.swiftLint],
    appDependencies: ModulePaths.Feature.allCases.map { .feature(target: $0) }
    + ModulePaths.Service.allCases.map { .service(target: $0) } + [
        .shared(target: .SwiftUIUtil)
    ],
    resources: ["Resources/**"],
    infoPlist: .file(path: "Support/Info.plist")
)
