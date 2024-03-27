//
//  NavigationController.swift
//  Seugi
//
//  Created by dgsw8th71 on 3/26/24.
//  Copyright © 2024 seugi. All rights reserved.
//

import Foundation

public class NavigationController: ObservableObject {
    @Published public var path: [ViewType] = []
    
    public init() {}
}
