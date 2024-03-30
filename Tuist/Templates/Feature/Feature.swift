import ProjectDescription

private let nameAttribute = Template.Attribute.required("name")

private let template = Template(
    description: "A template for a new feature module",
    attributes: [
        nameAttribute
    ],
    items: [
        .string(
            path: "Projects/Feature/\(nameAttribute)Feature/Example/\(nameAttribute)ViewExample.swift",
            contents: "import \(nameAttribute)Feature"
        ),
        .string(
            path: "Projects/Feature/\(nameAttribute)Feature/Sources/\(nameAttribute)View.swift",
            contents: "import BaseFeature"
        ),
        .file(
            path: "Projects/Feature/\(nameAttribute)Feature/Project.swift",
            templatePath: "Project.stencil"
        )
    ]
)
