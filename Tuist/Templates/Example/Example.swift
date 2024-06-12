import ProjectDescription

private let layerAttribute = Template.Attribute.required("layer")
private let nameAttribute = Template.Attribute.required("name")

private let template = Template(
    description: "A template for a new example module",
    attributes: [
        layerAttribute,
        nameAttribute
    ],
    items: [
        .string(
            path: "Projects/\(layerAttribute)/\(nameAttribute)\(layerAttribute)/Example/Source.swift",
            contents: "// made by tuist"
        )
    ]
)
