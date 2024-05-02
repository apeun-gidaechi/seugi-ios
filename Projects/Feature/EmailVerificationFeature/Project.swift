import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    type: .EmailVerification,
    include: [.Example, .Feature, .Interface],
    featureDependency: [
        .feature(.Interface, for: .Base),
        .domain(.Interface, for: .Auth)
    ]
)
