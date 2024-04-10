import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    target: .SchoolCode,
    targets: [
        .feature(target: .SchoolCode, dependencies: [
            .feature(target: .Base),
            .featureInterface(target: .SchoolCode)
        ]),
        .featureExample(target: .SchoolCode, dependencies: [
            .feature(target: .SchoolCode)
        ]),
        .featureInterface(target: .SchoolCode, dependencies: [])
    ]
)
