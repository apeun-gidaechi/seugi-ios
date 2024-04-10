import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    target: .LaunchScreen,
    targets: [
        .feature(target: .LaunchScreen, dependencies: [
            .feature(target: .Base)
        ]),
        .featureExample(target: .LaunchScreen, dependencies: [
            .feature(target: .LaunchScreen)
        ]),
        .featureInterface(target: .LaunchScreen, dependencies: [])
    ]
)
