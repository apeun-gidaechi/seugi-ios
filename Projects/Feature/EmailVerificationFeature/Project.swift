import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    type: .EmailVerification,
    include: [.Example, .Feature, .Interface]
)
