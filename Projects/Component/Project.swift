//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by dgsw8th71 on 3/22/24.
//

import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeComponent(
    resources: ["Resources/**"],
    dependency: [
        .SPM.Snapkit,
        .SPM.Nuke,
        .SPM.NukeUI,
        .SPM.Flow,
        .SPM.GoogleSignIn,
        .domain,
        .shared(of: .SwiftUIUtil),
    ],
    xcconfig: .relativeToXCConfig("Config.xcconfig")
)
