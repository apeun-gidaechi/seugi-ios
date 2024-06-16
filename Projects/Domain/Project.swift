import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeDomain(
    dependency: [
        .shared(of: .SwiftUtil),
        .shared(of: .GlobalThirdPartyLibrary),
        .SPM.Flow,
        .SPM.SwiftBok
    ]
)
