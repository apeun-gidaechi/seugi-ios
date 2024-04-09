import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeature(
    target: .SelectingJob,
    targets: [
        .feature(target: .SelectingJob, dependencies: [
            .feature(target: .Base)
        ]),
        .featureExample(target: .SelectingJob, dependencies: [
            .feature(target: .SelectingJob)
        ]),
        .featureInterface(target: .SelectingJob, dependencies: [])
    ]
)
