import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    type: .CreateGroupChat,
    include: [.Feature, .Interface, .Example],
    featureDependency: [
        .feature(of: .ChatDetail)
    ]
)
