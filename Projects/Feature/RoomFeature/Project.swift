import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    target: .RoomFeature,
    targets: [
        .makeFeature(target: .RoomFeature, dependencies: [
            .feature(target: .BaseFeature)
        ]),
        .makeFeatureExample(target: .RoomFeature, dependencies: [
            .feature(target: .RoomFeature)
        ])
    ]
)
