import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "Service",
    product: .staticFramework,
    scripts: [.swiftLint],
    dependencies: [
        .Project.ThirdPartyLib
    ]
)
