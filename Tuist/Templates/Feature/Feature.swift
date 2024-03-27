import ProjectDescription

private let nameAttribute = Template.Attribute.required("name")

private let template = Template(
    description: "A template for a new feature module",
    attributes: [
        nameAttribute
    ],
    items: [
        .string(
            path: "Projects/Feature/\(nameAttribute)Feature/Example/Sources.swift",
            contents: "// bestswlkh0310"
        ),
        .string(
            path: "Projects/Feature/\(nameAttribute)Feature/Sources/Sources.swift",
            contents: "// bestswlkh0310"
        ),
        .file(
            path: "Projects/Feature/\(nameAttribute)Feature/Project.swift",
            templatePath: "Project.stencil"
        )
    ]
)
