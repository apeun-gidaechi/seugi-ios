//
//  Path+.swift
//  ProjectDescriptionHelpers
//
//  Created by dgsw8th71 on 3/26/24.
//

import ProjectDescription

public extension ProjectDescription.Path {
    static func relativeToFeature(_ path: String) -> Self {
        return .relativeToRoot("Projects/Feature/\(path)")
    }
    static func relativeToSerivce(_ path: String) -> Self {
        return .relativeToRoot("Projects/Service/\(path)")
    }
    static func relativeToShared(_ path: String) -> Self {
        return .relativeToRoot("Projects/Shared/\(path)")
    }
    static func relativeToUserInterface(_ path: String) -> Self {
        return .relativeToRoot("Projects/UserInterface/\(path)")
    }
    static var app: Self {
        return .relativeToRoot("Projects/App")
    }
}
