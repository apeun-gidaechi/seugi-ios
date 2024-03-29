import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    target: .RootFeature,
    targets: [
        .makeFeature(target: .RootFeature, dependencies: [
            // base
            .feature(target: .BaseFeature),
            // onboarding
            .feature(target: .EmailSignInFeature),
            .feature(target: .EmailSignUpFeature),
            .feature(target: .JoinSchoolFeature),
            .feature(target: .LaunchScreenFeature),
            .feature(target: .OAuthSignUpFeature),
            .feature(target: .SelectingJobFeature),
            .feature(target: .StartFeature),
            // main
            .feature(target: .MainFeature),
            .feature(target: .HomeFeature),
            .feature(target: .ChatFeature),
            .feature(target: .ChatDetailFeature)
        ]),
        .makeFeatureExample(target: .RootFeature, dependencies: [
            .feature(target: .RootFeature)
        ])
    ],
    scripts: [.swiftLint]
)
