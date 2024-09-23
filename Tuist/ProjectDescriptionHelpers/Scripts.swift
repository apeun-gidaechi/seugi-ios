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
    
    static let periphery = TargetScript.pre(
        path: .relativeToScript("PeripheryRunScript.sh"),
        name: "Periphery",
        basedOnDependencyAnalysis: false
    )
}
