import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    target: .EmailSignUpFeature,
    targets: [
        .makeFeature(target: .EmailSignUpFeature, dependencies: [
            .feature(target: .BaseFeature)
        ]),
        .makeFeatureExample(target: .EmailSignUpFeature, dependencies: [
            .feature(target: .EmailSignUpFeature)
        ])
    ],
    scripts: [.swiftLint]
)
