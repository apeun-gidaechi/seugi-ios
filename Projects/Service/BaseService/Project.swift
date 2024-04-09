import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeService(
    target: .Base,
    targets: [
        .service(target: .Base, dependencies: [
            .shared(target: .GlobalThirdPartyLibrary)
        ]),
    ]
)
