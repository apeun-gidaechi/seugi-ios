import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    target: .SchoolCode,
    targets: [
        .feature(target: .SchoolCode, dependencies: [
            .feature(target: .Base)
        ]),
        .featureExample(target: .SchoolCode, dependencies: [
            .feature(target: .SchoolCode)
        ]),
        .featureInterface(target: .SchoolCode, dependencies: [])
    ]
)
