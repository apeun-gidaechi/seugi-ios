import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    target: .EmailSignUp,
    targets: [
        .feature(target: .EmailSignUp, dependencies: [
            .featureInterface(target: .Base),
            .featureInterface(target: .EmailSignUp)
        ]),
        .featureExample(target: .EmailSignUp, dependencies: [
            .feature(target: .EmailSignUp)
        ]),
        .featureInterface(target: .EmailSignUp, dependencies: [])
    ]
)
