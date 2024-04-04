import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    target: .CreateRoomFeature,
    targets: [
        .makeFeature(target: .CreateRoomFeature, dependencies: [
            .feature(target: .BaseFeature)
        ]),
        .makeFeatureExample(target: .CreateRoomFeature, dependencies: [
            .feature(target: .CreateRoomFeature)
        ])
    ]
)
