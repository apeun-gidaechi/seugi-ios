import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeShared(
    type: .Secret,
    include: [.Feature],
    featureDependency: [
        .SPM.Swinject
    ]
)
