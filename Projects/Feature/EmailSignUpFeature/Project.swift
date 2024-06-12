import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    type: .EmailSignUp,
    include: [.Feature, .Interface, .Example],
    featureDependency: [
        .feature(.Interface, for: .Base),
        .feature(.Interface, for: .EmailVerification)
    ]
)
