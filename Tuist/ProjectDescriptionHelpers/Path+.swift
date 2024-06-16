//
//  Path+.swift
//  ProjectDescriptionHelpers
//
//  Created by dgsw8th71 on 3/26/24.
//

import ProjectDescription

public extension ProjectDescription.Path {
    static var dIContainer: Self {
        .relativeToRoot("Projects/DIContainer")
    }
    static func app(_ path: String) -> Self {
        .relativeToRoot("Projects/App/\(path)")
    }
    static func relativeToFeature(_ path: String) -> Self {
        .relativeToRoot("Projects/Feature/\(path)")
    }
    static var component: Self {
        .relativeToRoot("Projects/Component")
    }
    static var domain: Self {
        .relativeToRoot("Projects/Domain")
    }
    static var data: Self {
        .relativeToRoot("Projects/Data")
    }
    static var shared: Self {
        .relativeToRoot("Projects/Shared")
    }
    static func relativeToXCConfig(_ path: String) -> Self {
        .relativeToRoot("XCConfig/\(path)")
    }
}
