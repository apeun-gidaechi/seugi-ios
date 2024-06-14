//
//  Router.swift
//  BaseFeature
//
//  Created by dgsw8th71 on 4/10/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import SwiftUI

public final class Router: ObservableObject {
    @Published public var navPath = NavigationPath()
    public init() {}

    public func navigate(to destination: any Hashable) {
        print("navigate - \(destination)")
        navPath.append(destination)
    }

    public func popToStack() {
        navPath.removeLast()
    }

    public func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
}
