import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    target: .RootFeature,
    targets: [
        .makeFeature(target: .RootFeature, dependencies: [
            // base
            .feature(target: .BaseFeature),
            // onboarding
            .feature(target: .OnboardingFeature),
            // main
            .feature(target: .MainFeature)
        ]),
        .makeFeatureExample(target: .RootFeature, dependencies: [
            .feature(target: .RootFeature)
        ])
    ],
    scripts: [.swiftLint]
)
