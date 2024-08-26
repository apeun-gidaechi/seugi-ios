import Foundation
import ProjectDescription

public struct ProjectEnvironment {
    public let name: String
    public let organizationName: String
    public let destinations: Destinations
    public let deploymentTargets: DeploymentTargets
}

public let env = ProjectEnvironment(
    name: "seugi",
    organizationName: "apeun-gidaechi",
    destinations: [.iPhone],
    deploymentTargets: .iOS("16.4")
)

public let baseBundleId = "com.\(env.name)"
