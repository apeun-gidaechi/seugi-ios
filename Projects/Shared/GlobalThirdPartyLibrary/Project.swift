//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by dgsw8th71 on 3/26/24.
//

import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeShared(
    target: .GlobalThirdPartyLibrary,
    targets: [
        .shared(target: .GlobalThirdPartyLibrary, dependencies: [
            .SPM.Swinject
        ])
    ]
)
