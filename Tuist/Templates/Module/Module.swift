import ProjectDescription

private let layerAttribute = Template.Attribute.required("name")
private let nameAttribute = Template.Attribute.required("name")

private let template = Template(
    description: "A template for a new module",
    attributes: [
        layerAttribute,
        nameAttribute
    ],
    items: [
        .file(
            path: "Projects/\(layerAttribute)/\(nameAttribute)\("\(layerAttribute)" == "Feature" || "\(layerAttribute)" == "Domain" ? "\(layerAttribute)" : "")/Project.swift",
            templatePath: "Project.stencil"
        ),
    ]
)
