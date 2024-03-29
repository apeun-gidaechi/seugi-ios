import ProjectDescription

private let nameAttribute = Template.Attribute.required("name")

private let template = Template(
    description: "A template for a new service module",
    attributes: [
        nameAttribute
    ],
    items: [
        .string(
            path: "Projects/Service/\(nameAttribute)Service/Sources/\(nameAttribute)Service.swift",
            contents: "import BaseService"
        ),
        .file(
            path: "Projects/Service/\(nameAttribute)Service/Project.swift",
            templatePath: "Project.stencil"
        ),
    ]
)
