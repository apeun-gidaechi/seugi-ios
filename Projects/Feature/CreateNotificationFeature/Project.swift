import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    type: .CreateNotification,
    include: [.Feature, .Example, .Interface]
)
