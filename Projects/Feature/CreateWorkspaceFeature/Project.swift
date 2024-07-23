import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    type: .CreateWorkspace,
    include: [.Feature, .Example, .Interface]
)
