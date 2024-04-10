import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    target: .Room,
    targets: [
        .feature(target: .Room, dependencies: [
            .feature(target: .Base),
            .featureInterface(target: .Room)
        ]),
        .featureExample(target: .Room, dependencies: [
            .feature(target: .Room)
        ]),
        .featureInterface(target: .Room, dependencies: [])
    ]
)
