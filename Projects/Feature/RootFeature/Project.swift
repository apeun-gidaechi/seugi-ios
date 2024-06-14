import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    type: .Root,
    include: [.Feature, .Interface, .Example],
    featureDependency: [
        .feature(of: .Onboarding),
        .feature(of: .JoinSchool),
        .feature(of: .Main)
    ]
)
