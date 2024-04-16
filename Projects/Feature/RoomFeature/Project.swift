import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    type: .Room,
    include: [.Feature, .Interface, .Example],
    featureDependency: [
        .feature(.Interface, for: .Base)
    ]
)
