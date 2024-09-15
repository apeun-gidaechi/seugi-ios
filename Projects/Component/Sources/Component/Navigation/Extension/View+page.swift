//
//  View+page.swift
//  Component
//
//  Created by hhhello0507 on 9/15/24.
//  Copyright © 2024 apeun-gidaechi. All rights reserved.
//

import SwiftUI

public extension View {
    func page(icon: SeugiIconography, hasBadge: Bool = false) -> Page {
        Page(icon: icon, hasBadge: hasBadge) { self }
    }
}
