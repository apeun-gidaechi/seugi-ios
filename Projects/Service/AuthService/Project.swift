import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeService(
    target: .AuthService,
    targets: [
        .makeService(target: .AuthService, dependencies: [
            .service(target: .BaseService)
        ])
    ]
)
