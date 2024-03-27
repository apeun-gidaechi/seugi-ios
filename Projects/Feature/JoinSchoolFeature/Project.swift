import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: ModulePaths.Feature.JoinSchoolFeature.rawValue,
    product: .staticLibrary,
    targets: [
        .feature(name: ModulePaths.Feature.JoinSchoolFeature.rawValue, dependencies: [
            .feature(target: .BaseFeature)
        ]),
        .example(name: ModulePaths.Feature.JoinSchoolFeature.rawValue,
         dependencies: [
            .feature(target: .JoinSchoolFeature)
         ])
    ],
    scripts: [.swiftLint]
)

