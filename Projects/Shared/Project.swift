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
    targets: [
        .shared(target: .DateUtil),
        .shared(target: .GlobalThirdPartyLibrary, dependencies: [
            .SPM.Swinject,
            .SPM.PublicInit
        ]),
        .shared(target: .Secret, dependencies: [
            .SPM.Swinject
        ]),
        .shared(target: .SwiftUIUtil),
        .shared(target: .SwiftUtil, dependencies: [
            .SPM.PublicInit
        ])
    ]
)
