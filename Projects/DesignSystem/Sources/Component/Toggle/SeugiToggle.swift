//
//  AlimoSwitch.swift
//  App
//
//  Created by dgsw8th71 on 1/7/24.
//  Copyright © 2024 b8nd. All rights reserved.
//

import SwiftUI

struct SeugiToggle: View {
    
    @Binding var isOn: Bool
    
    var body: some View {
        Toggle("", isOn: $isOn)
            .labelsHidden()
            .seugiForeground(.primary(.p300))
            .tint(.seugi(.primary(.p500)))
            .frame(width: 54, height: 28)
    }
}

#Preview {
    VStack {
        SeugiToggle(isOn: .constant(true))
        SeugiToggle(isOn: .constant(false))
    }
}
