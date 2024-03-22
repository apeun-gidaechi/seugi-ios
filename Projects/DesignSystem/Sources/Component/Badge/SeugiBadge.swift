//
//  AlimoBadge.swift
//  App
//
//  Created by dgsw8th71 on 1/7/24.
//  Copyright © 2024 b8nd. All rights reserved.
//

import SwiftUI

struct SeugiBadge: View {
    
    var type: SeugiBadgeType
    
    init(type: SeugiBadgeType = .large) {
        self.type = type
    }
    
    var body: some View {
        Circle()
            .foregroundStyle(Color.seugi(.gray(.g100)))
            .frame(width: type.width)
            .overlay {
                if type.hasLabel {
                    Text("N")
                        .foregroundStyle(Color.white)
                }
            }
    }
}
