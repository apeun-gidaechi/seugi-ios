import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeDomain(
    target: .Auth,
    targets: [
        .domain(target: .Auth, dependencies: [
            .domainInterface(target: .Base)
        ]),
        .domainInterface(target: .Auth, dependencies: [])
    ]
)
