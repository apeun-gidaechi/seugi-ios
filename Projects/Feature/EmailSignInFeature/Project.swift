import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    target: .EmailSignIn,
    targets: [
        .feature(target: .EmailSignIn, dependencies: [
            .feature(target: .Base),
            .featureInterface(target: .EmailSignIn)
        ]),
        .featureExample(target: .EmailSignIn, dependencies: [
            .feature(target: .EmailSignIn)
        ]),
        .featureInterface(target: .EmailSignIn, dependencies: [])
    ]
)
