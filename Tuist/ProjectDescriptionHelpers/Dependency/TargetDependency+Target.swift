import ProjectDescription

public extension TargetDependency {
    static var diContainer: TargetDependency {
        .project(
            target: ModulePaths.Single.DIContainer.rawValue,
            path: .dIContainer
        )
    }
    
    static var feature: TargetDependency {
        .project(
            target: "Feature",
            path: .feature
        )
    }
    
    static var component: TargetDependency {
        .project(
            target: ModulePaths.Single.Component.rawValue,
            path: .component
        )
    }
    
    static var domain: TargetDependency {
        .project(
            target: ModulePaths.Single.Domain.rawValue,
            path: .domain
        )
    }
    
    static var domainTesting: TargetDependency {
        .project(
            target: "\(ModulePaths.Single.Domain.rawValue)Testing",
            path: .domain
        )
    }
    
    static func data(
        of target: ModulePaths.Data
    ) -> TargetDependency {
        .project(
            target: "\(target.rawValue)",
            path: .data
        )
    }
    
    static func shared(
        of target: ModulePaths.Shared
    ) -> TargetDependency {
        .project(
            target: target.rawValue,
            path: .shared
        )
    }
}
