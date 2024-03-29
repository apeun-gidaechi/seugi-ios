import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: ModulePaths.Feature.JoinSchoolSuccessFeature.rawValue,
    product: .staticLibrary,
    targets: [
        .feature(name: ModulePaths.Feature.JoinSchoolSuccessFeature.rawValue, dependencies: [
            .feature(target: .BaseFeature)
        ]),
        .example(name: ModulePaths.Feature.JoinSchoolSuccessFeature.rawValue,
         dependencies: [
            .feature(target: .JoinSchoolSuccessFeature)
         ])
    ],
    scripts: [.swiftLint]
)

