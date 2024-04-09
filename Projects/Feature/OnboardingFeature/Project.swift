import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    target: .Onboarding,
    targets: [
        .feature(target: .Onboarding, dependencies: [
            .feature(target: .Base),
            .feature(target: .EmailSignIn),
            .feature(target: .EmailSignUp),
            .feature(target: .LaunchScreen),
            .feature(target: .OAuthSignUp),
            .feature(target: .SelectingJob),
            .feature(target: .Start)
        ]),
        .featureExample(target: .Onboarding, dependencies: [
            .feature(target: .Onboarding)
        ])
    ]
)
