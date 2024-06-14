import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeFeature(
    type: .Start,
    include: [.Feature, .Interface, .Example],
    featureDependency: [
        .feature(of: .OAuthSignUp, module: .Interface),
        .feature(of: .EmailSignIn, module: .Interface)
    ]
)
