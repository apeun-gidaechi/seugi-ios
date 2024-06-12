import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeCore(
    type: .UserDefault,
    include: [.Feature, .Interface]
)
