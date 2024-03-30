import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    target: .OnboardingFeature,
    targets: [
        .makeFeature(target: .OnboardingFeature, dependencies: [
            .feature(target: .BaseFeature),
            .feature(target: .EmailSignInFeature),
            .feature(target: .EmailSignUpFeature),
            .feature(target: .LaunchScreenFeature),
            .feature(target: .OAuthSignUpFeature),
            .feature(target: .SelectingJobFeature),
            .feature(target: .StartFeature)
        ]),
        .makeFeatureExample(target: .OnboardingFeature, dependencies: [
            .feature(target: .OnboardingFeature)
        ])
    ]
)
