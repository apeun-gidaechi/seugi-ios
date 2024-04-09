import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    target: .Chat,
    targets: [
        .feature(target: .Chat, dependencies: [
            .feature(target: .Base)
        ]),
        .featureExample(target: .Chat, dependencies: [
            .feature(target: .Chat)
        ])
    ]
)
