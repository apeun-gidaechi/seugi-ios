import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    target: .OAuthSignUp,
    targets: [
        .feature(target: .OAuthSignUp, dependencies: [
            .feature(target: .Base),
            .featureInterface(target: .OAuthSignUp)
        ]),
        .featureExample(target: .OAuthSignUp, dependencies: [
            .feature(target: .OAuthSignUp)
        ]),
        .featureInterface(target: .OAuthSignUp, dependencies: [])
    ]
)
