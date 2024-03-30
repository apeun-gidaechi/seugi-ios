import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    target: .RootFeature,
    targets: [
        .makeFeature(target: .RootFeature, dependencies: [
            .feature(target: .BaseFeature),
            .feature(target: .OnboardingFeature),
            .feature(target: .JoinSchoolFeature),
            .feature(target: .MainFeature),
        ]),
        .makeFeatureExample(target: .RootFeature, dependencies: [
            .feature(target: .RootFeature)
        ])
    ],
    scripts: [.swiftLint]
)
