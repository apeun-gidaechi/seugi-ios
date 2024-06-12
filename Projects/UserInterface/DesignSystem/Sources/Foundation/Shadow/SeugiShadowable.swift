//
//  SeugiShadowable.swift
//  DesignSystem
//
//  Created by dgsw8th71 on 3/23/24.
//  Copyright © 2024 seugi. All rights reserved.
//

import SwiftUI

protocol SeugiShadowable {
    var color: Color { get }
    var radius: CGFloat { get }
    var x: CGFloat { get }
    var y: CGFloat { get }
}
