import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    target: .Main,
    targets: [
        .feature(target: .Main, dependencies: [
            .feature(target: .Base),
            .feature(target: .Home),
            .feature(target: .Chat),
            .feature(target: .ChatDetail),
            .feature(target: .Room),
            .feature(target: .CreateRoom)
        ]),
        .featureExample(target: .Main, dependencies: [
            .feature(target: .Main)
        ])
    ]
)
