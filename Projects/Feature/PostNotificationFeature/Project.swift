import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    type: .PostNotification,
    include: [.Feature, .Example, .Interface],
    featureDependency: [
        .feature(of: .Notification)
    ]
)
