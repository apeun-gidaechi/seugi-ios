import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeDomain(
    dependency: [
        .SPM.SwiftBok
    ]
)
