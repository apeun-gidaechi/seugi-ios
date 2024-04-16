import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    type: .LaunchScreen,
    include: [.Feature, .Interface, .Example],
    featureDependency: [
        .feature(.Interface, for: .Base)
    ]
)
