//
//  Scripts.swift
//  ProjectDescriptionHelpers
//
//  Created by dgsw8th71 on 3/23/24.
//

import Foundation
import ProjectDescription

public extension TargetScript {
    
    
    static let swiftLintScript = """
ROOT_DIR=\(ProcessInfo.processInfo.environment["TUIST_ROOT_DIR"] ?? "")

${ROOT_DIR}/swiftlint --config ${ROOT_DIR}/.swiftlint.yml

"""
    static let swiftLint = TargetScript.pre(
        script: swiftLintScript,
        name: "SwiftLint",
        basedOnDependencyAnalysis: false
    )
}
