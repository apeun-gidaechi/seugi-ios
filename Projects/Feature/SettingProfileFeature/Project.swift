import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    type: .SettingProfile,
    include: [.Feature, .Example, .Interface]
)
