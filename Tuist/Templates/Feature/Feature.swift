import ProjectDescription

private let nameAttribute = Template.Attribute.required("name")
private let root = "Projects/Feature/\(nameAttribute)Feature/Sources"

private let template = Template(
    description: "A template for a new feature module",
    attributes: [
        nameAttribute
    ],
    items: [
        // MARK: - Sources
        .file(
            path: "\(root)/Assembly/\(nameAttribute)Assembly.swift",
            templatePath: "FeatureAssembly.stencil"
        ),
        .file(
            path: "\(root)/Factory/\(nameAttribute)FactoryImpl.swift",
            templatePath: "FeatureFactoryImpl.stencil"
        ),
        .file(
            path: "\(root)/Coordinator/\(nameAttribute)Coordinator.swift",
            templatePath: "FeatureCoordinator.stencil"
        ),
        .file(
            path: "\(root)/Scene/\(nameAttribute)View",
            templatePath: "FeatureView.stencil"
        ),
        // MARK: - Interface
        .file(
            path: "Projects/Feature/\(nameAttribute)Feature/Interface/\(nameAttribute)Factory.swift",
            templatePath: "InterfaceFactory.stencil"
        ),
        // MARK: - Example
        .file(
            path: "Projects/Feature/\(nameAttribute)Feature/Example/\(nameAttribute)Example.swift",
            templatePath: "Example.stencil"
        )
    ]
)
