import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    type: .JoinWorkspace,
    include: [.Feature, .Interface, .Example]
)
