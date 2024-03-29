//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by dgsw8th71 on 1/4/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeApp(
    target: .App,
    targets: [
        .makeApp(target: .App, dependenceis: ModulePaths.Feature.allCases.map { .feature(target: $0) }
                 + ModulePaths.Service.allCases.map { .service(target: $0) } + [
                    .shared(target: .SwiftUIUtil)
                 ], infoPlist: .file(path: "Support/Info.plist"))
    ],
    scripts: [.swiftLint]
)
