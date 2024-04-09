import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    target: .Home,
    targets: [
        .feature(target: .Home, dependencies: [
            .feature(target: .Base)
        ]),
        .featureExample(target: .Home, dependencies: [
            .feature(target: .Home)
        ])
    ]
)
