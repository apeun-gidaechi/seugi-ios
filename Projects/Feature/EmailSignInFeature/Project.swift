import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    target: .EmailSignInFeature,
    targets: [
        .makeFeature(target: .EmailSignInFeature, dependencies: [
            .feature(target: .BaseFeature)
        ]),
        .makeFeatureExample(target: .EmailSignInFeature, dependencies: [
            .feature(target: .EmailSignInFeature)
        ])
    ]
)
