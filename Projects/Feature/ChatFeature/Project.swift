import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    target: .ChatFeature,
    targets: [
        .makeFeature(target: .ChatFeature, dependencies: [
            .feature(target: .BaseFeature),
            .feature(target: .ChatDetailFeature)
        ]),
        .makeFeatureExample(target: .ChatFeature, dependencies: [
            .feature(target: .ChatFeature)
        ])
    ],
    scripts: [.swiftLint]
)

