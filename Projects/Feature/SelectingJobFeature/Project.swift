import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    type: .SelectingJob,
    include: [.Feature, .Interface, .Example],
    featureDependency: [
        .feature(.Interface, for: .Base)
    ]
)
