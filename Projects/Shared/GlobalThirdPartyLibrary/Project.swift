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
    type: .GlobalThirdPartyLibrary,
    dependency: [
        .SPM.Swinject,
        .SPM.PublicInit
    ]
)
