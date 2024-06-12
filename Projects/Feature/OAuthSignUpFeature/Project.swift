import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    type: .OAuthSignUp,
    include: [.Feature, .Example, .Interface],
    featureDependency: [
        .feature(.Interface, for: .Base)
    ]
)
