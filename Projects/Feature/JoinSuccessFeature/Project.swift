import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    target: .JoinSuccess,
    targets: [
        .feature(target: .JoinSuccess, dependencies: [
            .feature(target: .Base)
        ]),
        .featureExample(target: .JoinSuccess, dependencies: [
            .feature(target: .JoinSuccess)
        ]),
        .featureInterface(target: .JoinSuccess, dependencies: [])
    ]
)
