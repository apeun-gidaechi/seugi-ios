import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    type: .WorkspaceDetail,
    include: [.Feature, .Example, .Interface],
    featureDependency: [
        .feature(of: .SettingWorkspace),
        .feature(of: .CreateWorkspace),
        .feature(of: .JoinWorkspace)
    ]
)