import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeDomain(
    type: .Chat,
    include: [.Feature, .Interface, .Testing, .Tests],
    featureDependency: [
        .domain(.Interface, for: .Base)
    ]
)
