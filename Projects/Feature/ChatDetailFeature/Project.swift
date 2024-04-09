import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    target: .ChatDetail,
    targets: [
        .feature(target: .ChatDetail, dependencies: [
            .feature(target: .Base)
        ]),
        .featureExample(target: .ChatDetail, dependencies: [
            .feature(target: .ChatDetail)
        ])
    ]
)
