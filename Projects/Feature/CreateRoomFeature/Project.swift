import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    type: .CreateRoom,
    include: [.Feature, .Interface, .Example],
    exampleDependency: [
        .domainTesting
    ]
)
