import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    target: .JoinSuccessFeature,
    targets: [
        .makeFeature(target: .JoinSuccessFeature, dependencies: [
            .feature(target: .BaseFeature)
        ]),
        .makeFeatureExample(target: .JoinSuccessFeature, dependencies: [
            .feature(target: .JoinSuccessFeature)
        ])
    ],
    scripts: [.swiftLint]
)

