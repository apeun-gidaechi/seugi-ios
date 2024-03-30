import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    target: .StartFeature,
    targets: [
        .makeFeature(target: .StartFeature, dependencies: [
            .feature(target: .BaseFeature)
        ]),
        .makeFeatureExample(target: .StartFeature, dependencies: [
            .feature(target: .StartFeature)
        ])
    ]
)

