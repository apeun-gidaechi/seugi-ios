import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeDomain(
    type: .Auth,
    include: [.Feature, .Interface, .Testing, .Tests],
    featureDependency: [
        .domain(.Interface, for: .Base)
    ]
)
