import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    type: .ChatDetail,
    include: [.Feature, .Example, .Interface]
//
//    targets: [
//        .feature(target: .ChatDetail, dependencies: [
//            .featureInterface(target: .Base),
//            .featureInterface(target: .ChatDetail),
//        ]),
//        .featureExample(target: .ChatDetail, dependencies: [
//            .feature(target: .ChatDetail)
//        ]),
//        .featureInterface(target: .ChatDetail, dependencies: [])
//    ]
)
