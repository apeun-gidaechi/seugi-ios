import ProjectDescription

private let layerAttribute = Template.Attribute.required("layer")
private let nameAttribute = Template.Attribute.required("name")

private let template = Template(
    description: "A template for a new tests module",
    attributes: [
        layerAttribute,
        nameAttribute
    ],
    items: [
        .string(
            path: "Projects/\(layerAttribute)/\(nameAttribute)\(layerAttribute)/Tests/Source.swift",
            contents: "// made by tuist"
        )
    ]
)
