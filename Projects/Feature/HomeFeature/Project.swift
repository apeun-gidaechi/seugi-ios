import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    target: .Home,
    targets: [
        .feature(target: .Home, dependencies: [
            .feature(target: .Base),
            .featureInterface(target: .Home)
        ]),
        .featureExample(target: .Home, dependencies: [
            .feature(target: .Home)
        ]),
        .featureInterface(target: .Home, dependencies: [])
    ]
)
