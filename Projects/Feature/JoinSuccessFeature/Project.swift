import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    type: .JoinSuccess,
    include: [.Feature, .Interface, .Example],
    featureDependency: [
        .feature(.Interface, for: .Base)
    ]
)
