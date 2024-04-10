import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    target: .Start,
    targets: [
        .feature(target: .Start, dependencies: [
            .feature(target: .Base),
            .featureInterface(target: .Start),
            .featureInterface(target: .OAuthSignUp),
            .featureInterface(target: .EmailSignIn)
        ]),
        .featureExample(target: .Start, dependencies: [
            .feature(target: .Start)
        ]),
        .featureInterface(target: .Start, dependencies: [])
    ]
)
