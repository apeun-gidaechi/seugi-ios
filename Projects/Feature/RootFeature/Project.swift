import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    type: .Root,
    include: [.Feature, .Interface, .Example],
    featureDependency: [
        .feature(.Interface, for: .Base),
        .feature(.Interface, for: .Onboarding),
        .feature(.Interface, for: .JoinSchool),
        .feature(.Interface, for: .Main)
    ]
)
