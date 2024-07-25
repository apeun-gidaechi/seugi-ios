import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    type: .UpdateNotification,
    include: [.Feature, .Example, .Interface]
)
