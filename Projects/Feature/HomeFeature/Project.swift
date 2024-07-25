import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    type: .Home,
    include: [.Feature, .Interface, .Example],
    featureDependency: [
        .feature(of: .WorkspaceDetail),
        .feature(of: .CreateWorkspace),
        .feature(of: .JoinWorkspace)
    ]
)
