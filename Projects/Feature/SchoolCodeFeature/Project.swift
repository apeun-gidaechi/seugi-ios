import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    type: .SchoolCode,
    include: [.Feature, .Interface, .Example],
    featureDependency: [
        .feature(.Interface, for: .Base)
    ]
)
