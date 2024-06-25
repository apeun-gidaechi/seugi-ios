import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    type: .Notification,
    include: [.Feature, .Example, .Interface]
)
