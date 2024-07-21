import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    type: .Onboarding,
    include: [.Feature, .Interface, .Example],
    featureDependency: [
        .feature(of: .EmailSignIn),
        .feature(of: .EmailSignUp),
        .feature(of: .LaunchScreen),
        .feature(of: .OAuthSignUp),
        .feature(of: .Start)
    ]
)
