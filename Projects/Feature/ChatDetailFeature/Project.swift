import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    target: .ChatDetail,
    targets: [
        .feature(target: .ChatDetail, dependencies: [
            .featureInterface(target: .Base),
            .featureInterface(target: .ChatDetail),
        ]),
        .featureExample(target: .ChatDetail, dependencies: [
            .feature(target: .ChatDetail)
        ]),
        .featureInterface(target: .ChatDetail, dependencies: [])
    ]
)
