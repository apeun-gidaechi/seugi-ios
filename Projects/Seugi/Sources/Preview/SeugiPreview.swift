//
//  Preview.swift
//  Seugi
//
//  Created by dgsw8th71 on 3/23/24.
//  Copyright © 2024 seugi. All rights reserved.
//

import SwiftUI
import DesignSystem

enum SeugiPreview: String, CaseIterable {
    
    case color = "Color"
    
    var view: some View {
        Group {
            switch self {
            case .color: ColorPreview()
            }
        }
    }
    
    static var preview: some View {
        NavigationStack {
            List(Self.allCases, id: \.self) { preview in
                NavigationLink {
                    preview.view
                } label: {
                    Text("\(preview.rawValue) Preview")
                }
            }
            .navigationTitle("Seugi Preivew")
        }
    }
}
