//
//  BundleIdUtil.swift
//  ProjectDescriptionHelpers
//
//  Created by hhhello0507 on 8/26/24.
//

import ProjectDescription
import EnvironmentPlugin

public func makeBundleId(_ suffix: String) -> String {
    return "com.\(env.name).\(suffix)"
}
