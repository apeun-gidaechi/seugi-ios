import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    type: .Profile,
    include: [.Feature, .Example, .Interface],
    featureDependency: [
        .feature(of: .SettingProfile)
    ]
)
