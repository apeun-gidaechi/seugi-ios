import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeShared(
    type: .SwiftUIUtil,
    dependency: [
        .shared(of: .GlobalThirdPartyLibrary)
    ]
)
