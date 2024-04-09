import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    target: .JoinSchool,
    targets: [
        .feature(target: .JoinSchool, dependencies: [
            .feature(target: .Base),
            .feature(target: .SchoolCode),
            .feature(target: .JoinSuccess)
        ]),
        .featureExample(target: .JoinSchool, dependencies: [
            .feature(target: .JoinSchool)
        ])
    ]
)
