//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by dgsw8th71 on 3/22/24.
//

import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeUserInterface(
    type: .DesignSystem,
    include: [.Feature, .Example],
    featureDependency: [
        .shared(.Feature, for: .SwiftUIUtil),
        .SPM.Snapkit,
        .SPM.Nuke,
        .SPM.NukeUI,
        .SPM.Flow,
        .SPM.GoogleSignIn
    ]
)
