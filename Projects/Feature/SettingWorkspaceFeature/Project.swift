import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    type: .SettingWorkspace,
    include: [.Feature, .Example, .Interface]
)
