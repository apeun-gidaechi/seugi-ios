import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeService(
    target: .BaseService,
    targets: [
        .makeService(target: .BaseService, dependencies: [
            .shared(target: .GlobalThirdPartyLibrary)
        ]),
    ]
)
