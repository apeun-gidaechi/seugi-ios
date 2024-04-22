//
//  Path+.swift
//  ProjectDescriptionHelpers
//
//  Created by dgsw8th71 on 3/26/24.
//

import ProjectDescription

public extension ProjectDescription.Path {
    static func relativeToFeature(_ path: String) -> Self {
        .relativeToRoot("Projects/Feature/\(path)")
    }
    static func relativeToDomain(_ path: String) -> Self {
        .relativeToRoot("Projects/Domain/\(path)")
    }
    static func relativeToShared(_ path: String) -> Self {
        .relativeToRoot("Projects/Shared/\(path)")
    }
    static func relativeToUserInterface(_ path: String) -> Self {
        .relativeToRoot("Projects/UserInterface/\(path)")
    }
    static var app: Self {
        .relativeToRoot("Projects/App")
    }
    static var dIContainer: Self {
        .relativeToRoot("Projects/DIContainer")
    }
    
    static func relativeToXCConfig(_ path: String) -> Self {
        .relativeToRoot("XCConfig/\(path)")
    }
}
