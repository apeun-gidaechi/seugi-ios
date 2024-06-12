import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    type: .ChatDetail,
    include: [.Feature, .Example, .Interface],
    featureDependency: [
        .feature(.Interface, for: .Base),
        .domain(.Interface, for: .Chat)
    ]
)
