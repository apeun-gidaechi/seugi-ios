import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    target: .JoinSchoolFeature,
    targets: [
        .makeFeature(target: .JoinSchoolFeature, dependencies: [
            .feature(target: .BaseFeature)
        ]),
        .makeFeatureExample(target: .JoinSchoolFeature, dependencies: [
            .feature(target: .JoinSchoolFeature)
        ])
    ],
    scripts: [.swiftLint]
)

