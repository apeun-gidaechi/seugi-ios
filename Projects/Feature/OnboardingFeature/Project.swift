import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    target: .Onboarding,
    targets: [
        .feature(target: .Onboarding, dependencies: [
            .feature(target: .Base),
            .featureInterface(target: .EmailSignIn),
            .featureInterface(target: .EmailSignUp),
            .featureInterface(target: .LaunchScreen),
            .featureInterface(target: .OAuthSignUp),
            .featureInterface(target: .SelectingJob),
            .featureInterface(target: .Start)
        ]),
        .featureExample(target: .Onboarding, dependencies: [
            .feature(target: .Onboarding)
        ]),
        .featureInterface(target: .Onboarding, dependencies: [])
    ]
)
