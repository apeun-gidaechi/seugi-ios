import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    target: .JoinSchoolSuccessFeature,
    targets: [
        .makeFeature(target: .JoinSchoolSuccessFeature, dependencies: [
            .feature(target: .BaseFeature)
        ]),
        .makeFeatureExample(target: .JoinSchoolSuccessFeature, dependencies: [
            .feature(target: .JoinSchoolSuccessFeature)
        ])
    ],
    scripts: [.swiftLint]
)

