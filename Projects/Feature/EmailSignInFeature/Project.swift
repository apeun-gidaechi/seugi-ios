import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    type: .EmailSignIn,
    include: [.Feature, .Interface, .Example]
)
