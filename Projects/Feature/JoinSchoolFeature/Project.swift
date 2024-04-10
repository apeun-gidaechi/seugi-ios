import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    target: .JoinSchool,
    targets: [
        .feature(target: .JoinSchool, dependencies: [
            .featureInterface(target: .Base),
            .featureInterface(target: .JoinSchool),
            .featureInterface(target: .SchoolCode),
            .featureInterface(target: .JoinSuccess)
        ]),
        .featureExample(target: .JoinSchool, dependencies: [
            .feature(target: .JoinSchool)
        ]),
        .featureInterface(target: .JoinSchool, dependencies: [])
    ]
)
