import ProjectDescription

public extension TargetDependency {
    static var diContainer: TargetDependency {
        .project(
            target: "DIContainer",
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
            target: "Component",
            path: .component
        )
    }
    
    static var domain: TargetDependency {
        .project(
            target: "Domain",
            path: .domain
        )
    }
    
    static var domainTesting: TargetDependency {
        .project(
            target: "DomainTesting",
            path: .domain
        )
    }
    
    static func data(
        of target: Modules.Data
    ) -> TargetDependency {
        .project(
            target: "\(target.rawValue)",
            path: .data
        )
    }
    
    static func shared(
        of target: Modules.Shared
    ) -> TargetDependency {
        .project(
            target: target.rawValue,
            path: .shared
        )
    }
}
