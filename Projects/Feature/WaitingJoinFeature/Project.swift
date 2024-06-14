import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    type: .WaitingJoin,
    include: [.Example, .Feature, .Interface]
)
