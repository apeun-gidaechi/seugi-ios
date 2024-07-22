import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    type: .Main,
    include: [.Feature, .Interface, .Example],
    featureDependency: [
        .feature(of: .Home),
        .feature(of: .Chat),
        .feature(of: .ChatDetail),
        .feature(of: .CreateGroupChat),
        .feature(of: .Notification),
        .feature(of: .Profile)
    ]
)
