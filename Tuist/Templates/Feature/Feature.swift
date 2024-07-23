import ProjectDescription

private let nameAttribute = Template.Attribute.required("name")
private let root = "Projects/Feature/\(nameAttribute)Feature"

private let template = Template(
    description: "A template for a new feature module",
    attributes: [
        nameAttribute
    ],
    items: [
        // MARK: - Sources
        .file(
            path: "\(root)/Sources/Assembly/\(nameAttribute)Assembly.swift",
            templatePath: "FeatureAssembly.stencil"
        ),
        .file(
            path: "\(root)/Sources/Factory/\(nameAttribute)FactoryImpl.swift",
            templatePath: "FeatureFactoryImpl.stencil"
        ),
        .file(
            path: "\(root)/Sources/Coordinator/\(nameAttribute)Coordinator.swift",
            templatePath: "FeatureCoordinator.stencil"
        ),
        .file(
            path: "\(root)/Sources/Scene/\(nameAttribute)View.swift",
            templatePath: "FeatureView.stencil"
        ),
        .file(
            path: "\(root)/Project.swift",
            templatePath: "Project.stencil"
        ),
        // MARK: - Interface
        .file(
            path: "\(root)/Interface/\(nameAttribute)Factory.swift",
            templatePath: "InterfaceFactory.stencil"
        ),
        // MARK: - Example
        .file(
            path: "\(root)/Example/\(nameAttribute)Example.swift",
            templatePath: "Example.stencil"
        )
    ]
)
