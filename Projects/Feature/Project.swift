import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "Feature",
    product: .staticFramework,
    scripts: [.swiftLint],
    dependencies: [
        .Project.Service,
        .Project.DesignSystem
    ],
    resources: ["Resources/**"]
)
