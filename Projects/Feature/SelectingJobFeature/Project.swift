import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    target: .SelectingJobFeature,
    targets: [
        .makeFeature(target: .SelectingJobFeature, dependencies: [
            .feature(target: .BaseFeature)
        ]),
        .makeFeatureExample(target: .SelectingJobFeature, dependencies: [
            .feature(target: .SelectingJobFeature)
        ])
    ],
    scripts: [.swiftLint]
)

