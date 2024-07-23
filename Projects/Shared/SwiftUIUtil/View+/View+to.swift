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
        HStack(spacing: 0) {
            self
            Spacer()
        }
    }
    
    func toTrailing() -> some View {
        HStack(spacing: 0) {
            Spacer()
            self
        }
    }
    
    func toTop() -> some View {
        VStack(spacing: 0) {
            self
            Spacer()
        }
    }
    
    func toBottom() -> some View {
        VStack(spacing: 0) {
            Spacer()
            self
        }
    }
    
    func toCenter() -> some View {
        VStack(spacing: 0) {
            Spacer()
            HStack(spacing: 0) {
                Spacer()
                self
                Spacer()
            }
            Spacer()
        }
    }
    
    func toHorizontal() -> some View {
        HStack(spacing: 0) {
            Spacer()
            self
            Spacer()
        }
    }
    
    func toVertical() -> some View {
        VStack(spacing: 0) {
            Spacer()
            self
            Spacer()
        }
    }
}
