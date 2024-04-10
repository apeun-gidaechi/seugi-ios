import ProjectDescription

private let nameAttribute = Template.Attribute.required("name")

private let template = Template(
    description: "A template for a new domain module",
    attributes: [
        nameAttribute
    ],
    items: [
        .string(
            path: "Projects/Domain/\(nameAttribute)Domain/Sources/\(nameAttribute)Domain.swift",
            contents: "import BaseDomain"
        ),
        .string(
            path: "Projects/Domain/\(nameAttribute)Domain/Interface/\(nameAttribute)Interface",
            contents: "import Foundation"
        ),
        .file(
            path: "Projects/Domain/\(nameAttribute)Domain/Project.swift",
            templatePath: "Project.stencil"
        ),
    ]
)
