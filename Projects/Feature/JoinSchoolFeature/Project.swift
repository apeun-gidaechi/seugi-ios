import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    type: .JoinSchool,
    include: [.Feature, .Interface, .Example],
    featureDependency: [
        .feature(.Interface, for: .Base),
        .feature(.Interface, for: .SchoolCode),
        .feature(.Interface, for: .JoinSuccess)
    ]
)
