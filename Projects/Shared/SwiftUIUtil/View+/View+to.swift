//
//  View+to.swift
//  DesignSystem
//
//  Created by dgsw8th71 on 3/23/24.
//  Copyright © 2024 seugi. All rights reserved.
//

import SwiftUI

public extension View {
    func toLeading() -> some View {
        self.frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func toTrailing() -> some View {
        self.frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    func toTop() -> some View {
        self.frame(maxHeight: .infinity, alignment: .top)
    }
    
    func toBottom() -> some View {
        self.frame(maxHeight: .infinity, alignment: .bottom)
    }
    
    func toCenter() -> some View {
        self.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
    
    func toHorizontal() -> some View {
        self.frame(maxWidth: .infinity, alignment: .center)
    }
    
    func toVertical() -> some View {
        self.frame(maxHeight: .infinity, alignment: .center)
    }
}
