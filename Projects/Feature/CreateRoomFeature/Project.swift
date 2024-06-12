import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    type: .CreateRoom,
    include: [.Feature, .Interface, .Example],
    featureDependency: [
        .feature(.Interface, for: .Base)
    ]
)
