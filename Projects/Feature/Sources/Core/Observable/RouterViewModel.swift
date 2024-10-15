import SwiftUI

public final class RouterViewModel: ObservableObject {
    @Published public var navPath = NavigationPath()
    public init() {}

    public func navigate(to destination: any Hashable) {
        navPath.append(destination)
    }

    public func popToStack() {
        navPath.removeLast()
    }

    public func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
    
    public func replace(_ path: [any Hashable]) {
        navPath.removeLast(navPath.count)
        path.forEach {
            navPath.append($0)
        }
    }
}
