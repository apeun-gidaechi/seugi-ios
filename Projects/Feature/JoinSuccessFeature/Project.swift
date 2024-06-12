import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    type: .JoinSuccess,
    include: [.Feature, .Interface, .Example],
    featureDependency: [
        .feature(.Interface, for: .Base),
        .feature(.Interface, for: .SelectingJob),
        .domain(.Interface, for: .Workspace)
    ]
)
