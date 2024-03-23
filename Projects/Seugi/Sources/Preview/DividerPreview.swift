//
//  DividerPreview.swift
//  Seugi
//
//  Created by dgsw8th71 on 3/23/24.
//  Copyright © 2024 seugi. All rights reserved.
//

import SwiftUI
import DesignSystem

struct DividerPreview: View {
    var body: some View {
        VStack {
            SeugiDivider(thickness: .thin)
            SeugiDivider(thickness: .thick)
            HStack {
                SeugiDivider(thickness: .thin, direction: .vertical)
                SeugiDivider(thickness: .thick, direction: .vertical)
            }
        }
        .frame(height: 300)
    }
}
