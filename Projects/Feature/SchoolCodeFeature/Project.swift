import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    target: .SchoolCodeFeature,
    targets: [
        .makeFeature(target: .SchoolCodeFeature, dependencies: [
            .feature(target: .BaseFeature)
        ]),
        .makeFeatureExample(target: .SchoolCodeFeature, dependencies: [
            .feature(target: .SchoolCodeFeature)
        ])
    ],
    scripts: [.swiftLint]
)
