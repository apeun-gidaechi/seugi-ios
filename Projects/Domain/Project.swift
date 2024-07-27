import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeDomain(
    dependency: [
        .shared(of: .SwiftUtil),
        .SPM.SwiftBok
    ]
)
