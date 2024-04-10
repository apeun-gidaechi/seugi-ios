import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    target: .CreateRoom,
    targets: [
        .feature(target: .CreateRoom, dependencies: [
            .feature(target: .Base)
        ]),
        .featureExample(target: .CreateRoom, dependencies: [
            .feature(target: .CreateRoom)
        ]),
        .featureInterface(target: .CreateRoom, dependencies: [])
    ]
)
