//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by dgsw8th71 on 3/26/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: ModulePaths.Shared.GlobalThirdPartyLibrary.rawValue,
    product: .staticFramework,
    appDependencies: []
)
