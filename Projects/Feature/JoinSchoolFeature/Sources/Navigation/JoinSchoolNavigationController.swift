//
//  JoinSchoolNavigationController.swift
//  JoinSchoolFeature
//
//  Created by dgsw8th71 on 3/30/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import Foundation
import BaseFeature

final class JoinSchoolNavigationController: ObservableObject {
    @Published public var path: [ViewType.JoinSchool] = [.schoolCode]
    
    public func navigateTo(_ view: ViewType.JoinSchool) {
        path.append(view)
    }
    
    public func navigateToRoot() {
        path.removeAll()
    }
}
