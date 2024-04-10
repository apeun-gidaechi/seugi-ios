import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    target: .Main,
    targets: [
        .feature(target: .Main, dependencies: [
            .feature(target: .Base),
            .featureInterface(target: .Base),
            .featureInterface(target: .Home),
            .featureInterface(target: .Chat),
            .featureInterface(target: .ChatDetail),
            .featureInterface(target: .Room),
            .featureInterface(target: .CreateRoom)
        ]),
        .featureExample(target: .Main, dependencies: [
            .feature(target: .Main)
        ]),
        .featureInterface(target: .Main, dependencies: [])
    ]
)
