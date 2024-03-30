import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    target: .LaunchScreenFeature,
    targets: [
        .makeFeature(target: .LaunchScreenFeature, dependencies: [
            .feature(target: .BaseFeature)
        ]),
        .makeFeatureExample(target: .LaunchScreenFeature, dependencies: [
            .feature(target: .LaunchScreenFeature)
        ])
    ]
)

