//
//  Image+.swift
//  DesignSystem
//
//  Created by dgsw8th71 on 4/7/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import SwiftUI

public extension Image {
    
    init(image: SeugiImage) {
        self = Image(image.rawValue, bundle: .module)
    }
}
