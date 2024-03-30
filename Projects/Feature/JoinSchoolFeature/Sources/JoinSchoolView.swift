//
//  JoinSchoolView.swift
//  Feature
//
//  Created by dgsw8th71 on 3/26/24.
//  Copyright © 2024 seugi. All rights reserved.
//

import SwiftUI
import DesignSystem
import BaseFeature
import SchoolCodeFeature
import JoinSuccessFeature

public struct JoinSchoolView: View {
    
    @StateObject private var navController = JoinSchoolNavigationController()
    
    public init() {}
    
    public var body: some View {
        NavigationStack(path: $navController.path) {
            EmptyView()
                .navigationDestination(for: ViewType.JoinSchool.self) { viewType in
                    switch viewType {
                    case .schoolCode: SchoolCodeView { navController.navigateTo(.joinSuccess) }
                    case .joinSuccess: JoinSuccessView()
                    }
                }
        }
    }
}
