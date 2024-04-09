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
        .app(target: .App, dependenceis: [
            .feature(target: .Root)
        ], infoPlist: .file(path: "Support/Info.plist"))
    ]
)
