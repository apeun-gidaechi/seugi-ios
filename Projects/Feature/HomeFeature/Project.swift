import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    target: .HomeFeature,
    targets: [
        .makeFeature(target: .HomeFeature, dependencies: [
            .feature(target: .BaseFeature)
        ]),
        .makeFeatureExample(target: .HomeFeature, dependencies: [
            .feature(target: .HomeFeature)
        ])
    ]
)
