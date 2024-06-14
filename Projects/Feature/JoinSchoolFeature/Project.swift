import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    type: .JoinSchool,
    include: [.Feature, .Interface, .Example],
    featureDependency: [
        .feature(of: .SchoolCode),
        .feature(of: .JoinSuccess)
    ]
)
