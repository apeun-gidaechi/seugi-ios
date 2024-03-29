import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    target: .ChatDetailFeature,
    targets: [
        .makeFeature(target: .ChatDetailFeature, dependencies: [
            .feature(target: .BaseFeature)
        ]),
        .makeFeatureExample(target: .ChatDetailFeature, dependencies: [
            .feature(target: .ChatDetailFeature)
        ])
    ],
    scripts: [.swiftLint]
)

