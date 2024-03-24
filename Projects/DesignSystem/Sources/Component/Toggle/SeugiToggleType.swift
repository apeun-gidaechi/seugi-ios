//
//  SeugiToggleType.swift
//  DesignSystem
//
//  Created by dgsw8th71 on 3/23/24.
//  Copyright © 2024 seugi. All rights reserved.
//

import SwiftUI

public enum ToggleType {
    case `default`
    case checkbox(size: ToggleSize)
}

public enum ToggleSize: CGFloat, CaseIterable {
    case small = 16
    case medium = 20
    case large = 24
}
