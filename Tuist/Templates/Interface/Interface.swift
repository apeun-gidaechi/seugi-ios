import ProjectDescription

private let layerAttribute = Template.Attribute.required("layer")
private let nameAttribute = Template.Attribute.required("name")

private let template = Template(
    description: "A template for a new interface module",
    attributes: [
        layerAttribute,
        nameAttribute
    ],
    items: [
        .string(
            path: "Projects/\(layerAttribute)/\(nameAttribute)\(layerAttribute)/Interface/Source.swift",
            contents: "// made by tuist"
        )
    ]
)
