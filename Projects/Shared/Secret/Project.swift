import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeShared(
    type: .Secret,
    dependency: [
        .SPM.Swinject
    ]
)
