import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeFeature(
    type: .Start,
    include: [.Feature, .Interface, .Example],
    featureDependency: [
        .feature(.Interface, for: .Base),
        .feature(.Interface, for: .OAuthSignUp),
        .feature(.Interface, for: .EmailSignIn)
    ]
)
