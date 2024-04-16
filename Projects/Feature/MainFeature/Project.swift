import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    type: .Main,
    include: [.Feature, .Interface, .Example],
    featureDependency: [
        .feature(.Interface, for: .Base),
        .feature(.Interface, for: .Home),
        .feature(.Interface, for: .Chat),
        .feature(.Interface, for: .ChatDetail),
        .feature(.Interface, for: .Room),
        .feature(.Interface, for: .CreateRoom),
    ]
)
