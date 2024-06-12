import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    type: .Chat,
    include: [.Feature, .Interface, .Example],
    featureDependency: [
        .feature(.Interface, for: .Base),
        .domain(.Interface, for: .Chat)
    ]
)
