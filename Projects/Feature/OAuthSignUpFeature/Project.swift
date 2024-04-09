import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    target: .OAuthSignUp,
    targets: [
        .feature(target: .OAuthSignUp, dependencies: [
            .feature(target: .Base)
        ]),
        .featureExample(target: .OAuthSignUp, dependencies: [
            .feature(target: .OAuthSignUp)
        ])
    ]
)
