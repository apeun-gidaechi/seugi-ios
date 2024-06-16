import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeShared(
    type: .SwiftUtil,
    dependency: [
        .shared(of: .GlobalThirdPartyLibrary),
        .SPM.PublicInit
    ]
)
