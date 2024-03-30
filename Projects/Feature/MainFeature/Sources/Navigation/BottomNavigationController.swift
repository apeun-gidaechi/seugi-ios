//
//  BottomNavigationController.swift
//  MainFeature
//
//  Created by dgsw8th71 on 3/27/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import BaseFeature
import Foundation
import DesignSystem

class BottomNavigationController: ObservableObject {
    
    @Published var selectedTab: SeugiBottomNavigationType = .home
}
