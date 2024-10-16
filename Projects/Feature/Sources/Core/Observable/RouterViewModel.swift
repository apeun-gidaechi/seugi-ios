import SwiftUI

final class RouterViewModel: ObservableObject {
    @Published var navPath = NavigationPath()
    init() {}

    func navigate(to destination: any Hashable) {
        navPath.append(destination)
    }

    func popToStack() {
        navPath.removeLast()
    }

    func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
    
    func replace(_ path: [any Hashable]) {
        navPath.removeLast(navPath.count)
        path.forEach {
            navPath.append($0)
        }
    }
}
