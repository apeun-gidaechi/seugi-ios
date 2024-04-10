import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    target: .Chat,
    targets: [
        .feature(target: .Chat, dependencies: [
            .featureInterface(target: .Base),
            .featureInterface(target: .Chat)
        ]),
        .featureExample(target: .Chat, dependencies: [
            .feature(target: .Chat)
        ]),
        .featureInterface(target: .Chat, dependencies: [])
    ]
)
