import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeDomain(
    type: .Workspace,
    include: [.Feature, .Interface, .Testing],
    featureDependency: [
        .domain(.Interface, for: .Base)
    ]
)
