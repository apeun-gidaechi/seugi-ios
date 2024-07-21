import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    type: .Home,
    include: [.Feature, .Interface, .Example],
    featureDependency: [
        .feature(of: .JoinSchool)
    ]
)
