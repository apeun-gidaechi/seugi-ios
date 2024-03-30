import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    target: .BaseFeature,
    targets: [
        .makeFeature(target: .BaseFeature, dependencies: [
            .userInterface(target: .DesignSystem),
            .shared(target: .GlobalThirdPartyLibrary),
            .shared(target: .SwiftUIUtil)
        ])
    ]
)
