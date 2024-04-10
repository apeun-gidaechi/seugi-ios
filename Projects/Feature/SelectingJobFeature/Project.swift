import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    target: .SelectingJob,
    targets: [
        .feature(target: .SelectingJob, dependencies: [
            .featureInterface(target: .Base),
            .featureInterface(target: .SelectingJob)
        ]),
        .featureExample(target: .SelectingJob, dependencies: [
            .feature(target: .SelectingJob)
        ]),
        .featureInterface(target: .SelectingJob, dependencies: [])
    ]
)
