import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    type: .Onboarding,
    include: [.Feature, .Interface, .Example],
    featureDependency: [
        .feature(.Interface, for: .Base),
        .feature(.Interface, for: .EmailSignIn),
        .feature(.Interface, for: .EmailSignUp),
        .feature(.Interface, for: .LaunchScreen),
        .feature(.Interface, for: .OAuthSignUp),
        .feature(.Interface, for: .SelectingJob),
        .feature(.Interface, for: .Start)
    ]
)
