import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: ModulePaths.Feature.RootFeature.rawValue,
    product: .staticLibrary,
    targets: [
        .feature(name: ModulePaths.Feature.RootFeature.rawValue, dependencies: [
            // base
            .feature(target: .BaseFeature),
            // onboarding
            .feature(target: .EmailSignInFeature),
            .feature(target: .EmailSignUpFeature),
            .feature(target: .JoinSchoolFeature),
            .feature(target: .LaunchScreenFeature),
            .feature(target: .OAuthSignUpFeature),
            .feature(target: .SelectingJobFeature),
            .feature(target: .StartFeature),
            // main
            .feature(target: .MainFeature),
            .feature(target: .HomeFeature),
            .feature(target: .ChatFeature),
            .feature(target: .ChatDetailFeature)
        ]),
        .example(name: ModulePaths.Feature.RootFeature.rawValue,
         dependencies: [
            .feature(target: .RootFeature)
         ])
    ],
    scripts: [.swiftLint]
)

