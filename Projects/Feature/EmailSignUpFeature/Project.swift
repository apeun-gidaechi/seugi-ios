import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    target: .EmailSignUp,
    targets: [
        .feature(target: .EmailSignUp, dependencies: [
            .feature(target: .Base)
        ]),
        .featureExample(target: .EmailSignUp, dependencies: [
            .feature(target: .EmailSignUp)
        ])
    ]
)
