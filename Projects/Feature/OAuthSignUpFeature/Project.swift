import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    target: .OAuthSignUpFeature,
    targets: [
        .makeFeature(target: .OAuthSignUpFeature, dependencies: [
            .feature(target: .BaseFeature)
        ]),
        .makeFeatureExample(target: .OAuthSignUpFeature, dependencies: [
            .feature(target: .OAuthSignUpFeature)
        ])
    ]
)

