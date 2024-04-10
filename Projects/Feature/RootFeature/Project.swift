import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    target: .Root,
    targets: [
        .feature(target: .Root, dependencies: [
            .feature(target: .Base),
            .featureInterface(target: .Root),
            .featureInterface(target: .Onboarding),
            .featureInterface(target: .JoinSchool),
            .featureInterface(target: .Main)
        ]),
        .featureExample(target: .Root, dependencies: [
            .feature(target: .Root)
        ]),
        .featureInterface(target: .Root, dependencies: [])
    ]
)
