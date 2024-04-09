import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    target: .Root,
    targets: [
        .feature(target: .Root, dependencies: [
            .feature(target: .Base),
            .feature(target: .Onboarding),
            .feature(target: .JoinSchool),
            .feature(target: .Main)
        ]),
        .featureExample(target: .Root, dependencies: [
            .feature(target: .Root)
        ])
    ]
)
