import ProjectDescription

private let nameAttribute = Template.Attribute.required("name")

private let template = Template(
    description: "A template for a new service module",
    attributes: [
        nameAttribute
    ],
    items: [
        .string(
            path: "Projects/Service/\(nameAttribute)Service/Sources/Sources.swift",
            contents: " "
        ),
        .file(
            path: "Projects/Service/\(nameAttribute)Service/Project.swift",
            templatePath: "Project.stencil"
        ),
    ]
)
